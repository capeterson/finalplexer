public with sharing class Finalplexer implements Finalizer{

    private List<Finalizer> delegates = new List<Finalizer>();

    public void addFinalizer(Finalizer f){
        if(f == null){ throw new IllegalArgumentException('Finalplexer does not support attaching null objects as Finalizer');  }
        delegates.add(f);
    }

    public List<Finalizer> getFinalizers(){
        return delegates.clone(); //defensive copy to avoid callers accidentally mutating internal state
    }

    public void execute(FinalizerContext ctx){
        for(Finalizer f:delegates){
            f.execute(ctx);
        }
    }

    private class FinalizerWrapper{
        private Finalizer f;
        private String label;
    }

}