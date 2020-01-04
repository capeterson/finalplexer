@isTest
public class FinalPlexerTest {
    private static Boolean didExecutionAffirmingFinalizerRun = false;

    @isTest
    private static void sanity(){
        FinalPlexer fp = FinalPlexer.newInstance();
        ExecutionAffirmingFinalizer exe = new ExecutionAffirmingFinalizer();
        fp.addFinalizer(exe);
        System.assertEquals(1, fp.getFinalizers().size());
        System.assert( exe === fp.getFinalizers()[0] );

        DummyQueueable dq = new DummyQueueable();
        dq.injectedFInalizer = (Finalizer) fp;

        Test.startTest();
            System.enqueueJob(dq);
        Test.stopTest();

        System.assertEquals(true, didExecutionAffirmingFinalizerRun, 'ExecutionAffirmingFinalizer did not run!');
    }

    @testVisible
    public class DummyQueueable implements Queueable{
        public Finalizer injectedFInalizer;

        public void execute(QueueableContext ctx){
            System.attachFinalizer(injectedFInalizer);
        }
    }

    @testVisible
    public class ExecutionAffirmingFinalizer implements Finalizer{

        public void execute(FinalizerContext ctx){
            System.debug('ExecutionAffirmingFinalizer ran!');
            didExecutionAffirmingFinalizerRun = true;
        }

    }
}