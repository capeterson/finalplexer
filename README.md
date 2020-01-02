Finalplexer is an open source implementation of a Finalizer multiplexer.

Apex  only allows a single `Finalizer` to be attached per Queueable job, but what if you want to have a re-usable finalizer for your logging framework, and another for your retry framework?

Enter Finalplexer: a single Finalizer object that in turn does nothing other than delegate to any number of finalizers at execution time.

Do note, that as this is a pure Apex abstraction and your finalizers are sharing a single Apex execution context in practice you are still subject to limits cumulatively across all finalizers that are multiplexed. Specifically:

- Only one async job can be enqueued per finalizer execution. Finalplexer can't solve this - if multiple finalizers it's trying to multiplex try and enqueue jobs it will fail.
- One set of limits (CPU, DML, etc) applied for all multiplexed finalizers
- All multiplexed finalizers are still in the same database transaction - be *really* careful about making sync callouts from finalizers you're multiplexing!