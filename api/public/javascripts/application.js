var App = new Ext.App({});

// Create a standard HttpProxy instance.
var proxy = new Ext.data.HttpProxy({
    url: '/pretty_products.json'
});

// Typical JsonReader.  Notice additional meta-data params for defining the core attributes of your json-response
var reader = new Ext.data.JsonReader({
    idProperty: 'id',
    root: 'data',
    successProperty: "success",
    messageProperty: 'message',
}, [
    {name: 'id'},
    {name: 'name', allowBlank: false},
    {name: 'price', allowBlank: false},
    {name: 'description', allowBlank: false},
    {name: 'stock', allowBlank: false},
    {name: "color", allowBlank: true},
    {name: "size", allowBlank: true},
]);

// The new DataWriter component.
var writer = new Ext.data.JsonWriter({
    encode: false,   // <-- don't return encoded JSON -- causes Ext.Ajax#request to send data using jsonData config rather than HTTP params
});

// Typical Store collecting the Proxy, Reader and Writer together.
var store = new Ext.data.Store({
    id: 'product',
    restful: true,     // <-- This Store is RESTful
    proxy: proxy,
    reader: reader,
    writer: writer    // <-- plug a DataWriter into the store just as you would a Reader
});

// load the store immeditately
store.load();

////
// ***New*** centralized listening of DataProxy events "beforewrite", "write" and "writeexception"
// upon Ext.data.DataProxy class.  This is handy for centralizing user-feedback messaging into one place rather than
// attaching listenrs to EACH Store.
//
// Listen to all DataProxy beforewrite events
//
Ext.data.DataProxy.addListener('beforewrite', function(proxy, action) {
    App.setAlert(App.STATUS_NOTICE, "Before " + action);
});

////
// all write events
//
Ext.data.DataProxy.addListener('write', function(proxy, action, result, res, rs) {
    App.setAlert(true, action + ':' + (res.message || "OK"));
});

////
// all exception events
//
Ext.data.DataProxy.addListener('exception', function(proxy, type, action, options, res) {
    App.setAlert(false, "Something bad happend while executing " + action + ": " + res.message);
});

// Let's pretend we rendered our grid-columns with meta-data from our ORM framework.
var userColumns =  [
    {header: "ID", width: 50, sortable: true, dataIndex: 'id'},
    {header: "Name", width: 100, sortable: true, dataIndex: 'name', editor: new Ext.form.TextField({})},
    {header: "Price", width: 50, sortable: true, dataIndex: 'price', editor: new Ext.form.TextField({})},
    {header: "Description", width: 250, sortable: true, dataIndex: 'description', editor: new Ext.form.TextField({})},
    {header: "Stock", width: 50, sortable: true, dataIndex: 'stock', editor: new Ext.form.TextField({})}
];

var filters = new Ext.ux.grid.GridFilters({
    // encode and local configuration options defined previously for easier reuse
    encode: false, // json encode the filter query
    local: true,   // defaults to false (remote filtering)
    filters: [{
        type: 'numeric',
        dataIndex: 'id'
    }, {
        type: 'string',
        dataIndex: 'name'
    }, {
        type: 'numeric',
        dataIndex: 'price'
    }, {
        type: 'string',
        dataIndex: 'description'
    }, {
        type: 'numeric',
        dataIndex: 'stock'
    }]
});


Ext.onReady(function() {
    Ext.QuickTips.init();

    // use RowEditor for editing
    var editor = new Ext.ux.grid.RowEditor({
        saveText: 'Update'
    });

    // Create a typical GridPanel with RowEditor plugin
    var userGrid = new Ext.grid.GridPanel({
        renderTo: 'user-grid',
        iconCls: 'icon-grid',
        frame: true,
        title: 'Products',
        autoScroll: true,
        height: 500,
        width: 500,
        store: store,
        plugins: [editor, filters],
        columns : userColumns,
        tbar: [{
            text: 'Add',
            iconCls: 'silk-add',
            handler: onAdd
        }, '-', {
            text: 'Delete',
            iconCls: 'silk-delete',
            handler: onDelete
        }, '-'],
        viewConfig: {
            forceFit: true
        }
    });
    
    userGrid.on("rowclick", function(grid, index, event){
      var id = grid.getStore().getAt(index).id;
      //console.info(id);
      fs.getForm().load({url:"pretty_products/"+id+".json", method:"GET", waitMsg:'Loading'});      
      submit.enable();
    });
    
    /**
     * onAdd
     */
    function onAdd(btn, ev) {
        var u = new userGrid.store.recordType({
            name : '',
            price : '',
            description : '',
            stock : ''
        });
        editor.stopEditing();
        userGrid.store.insert(0, u);
        editor.startEditing(0);
    }
    /**
     * onDelete
     */
    function onDelete() {
        var rec = userGrid.getSelectionModel().getSelected();
        if (!rec) {
            return false;
        }
        userGrid.store.remove(rec);
    }
    
    
    
    // turn on validation errors beside the field globally
    Ext.form.Field.prototype.msgTarget = 'side';

    var fs = new Ext.FormPanel({
        frame: true,
        title:'Product details',
        labelAlign: 'right',
        labelWidth: 85,
        width:500,
        waitMsgTarget: true,

        reader : reader,

        items: [
            new Ext.form.FieldSet({
                title: 'Contact Information',
                autoHeight: true,
                defaultType: 'textfield',
                items: [
                    {
                        name: 'id',
                        hidden: true,
                        width:370
                    }, {
                        fieldLabel: 'Name',
                        emptyText: 'Name',
                        name: 'name',
                        width:370
                    }, {
                        fieldLabel: 'Price',
                        emptyText: 'Price',
                        name: 'price',
                        width:370
                    }, {
                        fieldLabel: 'Description',
                        emptyText: 'Description',
                        name: 'description',
                        xtype: "textarea",
                        height: 120,
                        width:370
                    }, {
                        fieldLabel: 'Stock',
                        emptyText: 'Stock',
                        name: 'stock',
                        width:370
                    },
                                      
                    new Ext.form.ComboBox({
                      fieldLabel: 'Color',
                      name:'color',
                      store: new Ext.data.ArrayStore({
                          fields: ['abbr', 'color'],
                          data : [["Yellow", "Yellow"], ["Blue", "Blue"], ["Gray", "Gray"], ["Red", "Red"], ["Black", "Black"], ["White", "White"]],
                      }),
                      valueField:'abbr',
                      displayField:'color',
                      typeAhead: true,
                      mode: 'local',
                      triggerAction: 'all',
                      emptyText:'Select a color...',
                      selectOnFocus:true,
                      width:370
                   }),

                    {
                        fieldLabel: 'Size',
                        emptyText: 'Size',
                        name: 'size',
                        width:370
                    }, 
                    

                ]
            })
        ]
    });

    // explicit add
    var submit = fs.addButton({
        text: 'Submit',
        disabled:true,
        handler: function(){
          var id = fs.getForm().getValues().id;
          
          var data = {};
          $.each(fs.getForm().getValues(), function(key, value){
            data["data["+key+"]"]  = value;
          });
          
          $.ajax({ 
            type: 'PUT',
            url: "/pretty_products/"+id+".json",
            data: data,
            success : function(){
              fs.getForm().load({url:"pretty_products/"+id+".json", method:"GET", waitMsg:'Loading'});
              userGrid.getStore().reload();
            }
          });
          
          
          //fs.getForm().submit({url:'pretty_products.json', waitMsg:'Saving Data...', submitEmptyText: false});
        }
    });

    fs.render('record-form');

    fs.on({
        actioncomplete: function(form, action){
            if(action.type == 'load'){
                submit.enable();
            }
        }
    });
    

});
