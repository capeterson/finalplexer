public with sharing class FinalPlexer implements Finalizer{

    private List<Finalizer> delegates = new List<Finalizer>();

    private FinalPlexer(){} //block construction in favor of a static factory

    public static FinalPlexer newInstance(){
        return new Finalplexer();
    }

    public void addFinalizer(Finalizer f){
        if(f == null){ throw new IllegalArgumentException('Finalplexer does not support attaching null objects as Finalizer');  }
        delegates.add(f);
    }

    public List<Finalizer> getFinalizers(){
        return delegates.clone(); //defensive copy to avoid callers accidentally mutating internal state
    }

    public void execute(FinalizerContext ctx){
        System.debug(LoggingLevel.FINER, 'Starting FinalPlexer execution of '+delegates.size()+' finalizers.');
        for(Finalizer f:delegates){
            f.execute(ctx);
        }
        System.debug(LoggingLevel.FINER, 'Finishing FinalPlexer execution');
    }

    private class FinalizerWrapper{
        private Finalizer f;
        private String label;
    }

}