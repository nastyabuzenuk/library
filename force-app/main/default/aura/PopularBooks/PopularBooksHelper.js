({
    setColumns : function(component) {
        component.set('v.columns',[
            {label: 'Book', fieldName: 'Name' , type: 'text'},
            {label:'Author', fieldName:'Author__c', type:'text'},
            {label:'Status' , fieldName:'Status__c', type:'text'}
        ])
    },

    getTopBooks: function(component,event,helper){
        var action = component.get("c.getTopBooks");

        action.setCallback(this, function(response){
            component.set("v.books", response.getReturnValue());
        });

        $A.enqueueAction(action);
    }
})
