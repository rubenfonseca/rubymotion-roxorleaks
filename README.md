# RoxorVM memleak with MagicalRecord example

This is a test project to show how RubyMotion is leaking an entire RoxorVM (144kb) everytime MagicalRecord creates a new private queue backed managed object context.

## How to detect the leak?

- Compile the project and start it on the simulator
- Open Instruments.app and attach to the running process, using the Allocations template
- Click the "Spawn" button multiple times

Result: The amount of allocated memory keeps going up, and the number of RoxorVM never goes down.

## How to generate a backtrace of the leak?

    $ sudo dtrace -n 'pid<PID HERE>::RoxorVM??RoxorVM():entry { printf("%x", arg0); ustack(20,0); }'
    
Replace `<PID HERE>` with the PID of the running process in the Simulator. Click the button and those backtraces start to appear.

Example backtrace:

    CPU     ID                    FUNCTION:NAME
    0 289683         RoxorVM::RoxorVM():entry 9477460
              roxorleaks`RoxorVM::RoxorVM()
              roxorleaks`rb_vm_current_vm+0x36
              roxorleaks`rb_vm_call+0x6c
              roxorleaks`rb_check_convert_type+0xc6
              roxorleaks`rb_proc_check_and_call+0x3a
              roxorleaks`__unnamed_144+0x36
              roxorleaks`__51+[MagicalRecord(Actions) saveWithBlock:completion:]_block_invoke+0x25
              CoreData`developerSubmittedBlockToNSManagedObjectContextPerform_privateasync+0x53
              libdispatch.dylib`_dispatch_client_callout+0xe
              libdispatch.dylib`_dispatch_queue_drain+0xef
              libdispatch.dylib`_dispatch_queue_invoke+0x3b
              libdispatch.dylib`_dispatch_root_queue_drain+0xe7
              libdispatch.dylib`_dispatch_worker_thread2+0x27
              libsystem_c.dylib`_pthread_wqthread+0x1b9
              libsystem_c.dylib`start_wqthread+0x1e

If you hook into the `RoxorVM::~RoxorVM()` method, it is never called. So the entire VM continues to exist forever.

### Small note

Please note that using just regular RubyMotion `Dispatch::Queue` doesn't trigger the memory leak.


