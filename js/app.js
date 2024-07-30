Ext.application({
    name: 'UserApp',
    launch: function() {
        var userStore = Ext.create('Ext.data.Store', {
            fields: ['user_id', 'user_name', 'education', 'cities'],
            proxy: {
                type: 'ajax',
                url: 'php/get_users.php',
                reader: {
                    type: 'json',
                    rootProperty: ''
                }
            },
            autoLoad: true
        });

        var grid = Ext.create('Ext.grid.Panel', {
            store: userStore,
            plugins: ['gridHeaderFilters', {
                ptype: 'cellediting',
                clicksToEdit: 1
            }],
            columns: [
                { text: 'ID', dataIndex: 'user_id', hidden: true },
                {
                    headerFilter: {
                        xtype: 'textfield',
                        emptyText: 'Имя',
                        dataIndex: 'user_name',
                        style: {
                            width: '85%'
                        },
                    },
                    text: 'Name',
                    dataIndex: 'user_name'
                },
                {
                    headerFilter: {
                        xtype: 'textfield',
                        emptyText: 'Образование',
                        dataIndex: 'education',
                        style: {
                            width: '85%'
                        }
                    },
                    text: 'Education',
                    dataIndex: 'education',
                    editor: {
                        xtype: 'textfield'
                    }
                },
                {
                    headerFilter: {
                        xtype: 'textfield',
                        emptyText: 'Города',
                        dataIndex: 'cities',
                        style: {
                            width: '85%'
                        }
                    },
                    text: 'Cities',
                    dataIndex: 'cities'
                }
            ],
            listeners: {
                edit: function(editor, context) {
                    console.log(context.record.data);
                    Ext.Ajax.request({
                        url: 'php/update_education.php',
                        method: 'POST',
                        jsonData: context.record.data,
                        success: function(response) {
                            var result = Ext.decode(response.responseText);
                            Ext.Msg.alert('Статус', result.message);
                        },
                        failure: function(response) {
                            var result = Ext.decode(response.responseText);
                            Ext.Msg.alert('Статус', result.message);
                        }
                    });
                }
            },
            height: 400,
            width: 600,
            renderTo: Ext.getBody()
        });

        Ext.create('Ext.container.Viewport', {
            layout: 'hbox',
            items: [grid]
        });
    }
});

// Плагин для фильтрации в заголовке столбца
Ext.define('globalApp.plugins.gridHeaderFilters', {
    extend: 'Ext.plugin.Abstract',
    alias: 'plugin.gridHeaderFilters',

    init: function(grid) {
        grid.on({
            boxready: this.onGridRender,
            single: true,
            scope: this
        });

        this.filters = {};
    },

    destroy: function() {},

    onGridRender: function(grid) {
        var me = this;

        grid.getColumns().forEach(function(column) {
            if (column && column.headerFilter) {
                column.textEl.child('span').remove();
                column.triggerEl.hide();

                if (Ext.isEmpty(column.config.headerFilter.sort)) {
                    column.sortable = false;
                }

                var inputCmp = Ext.create(column.headerFilter);
                inputCmp.enableKeyEvents = true;
                inputCmp.on('change', function(cmp) {
                    if (cmp.defferedFilter) clearTimeout(cmp.defferedFilter);
                    var value = Ext.isEmpty(cmp.value) ? '' : String(cmp.value);
                    cmp.defferedFilter = setTimeout(function() {
                        me.filters[column.dataIndex] = {
                            property: column.dataIndex,
                            value: value
                        };
                        me.doFilter(column.dataIndex);
                    }, 400);
                });

                Ext.create('Ext.container.Container', {
                    renderTo: column.textEl,
                    itemId: 'headerFilterContainer',
                    cls: 'headerFilterContainer',
                    items: inputCmp
                });
            }
            if (column && column.lastColumn) {
                column.textEl.child('span').remove();
            }
        });
    },

    doFilter: function(dataIndex) {
        var me = this,
            store = me.cmp.getStore();
        var filterParams = me.filters[dataIndex],
            filter = new Ext.util.Filter({
                id: filterParams.property,
                filterFn: function(record) {
                    if (record.get(filterParams.property)) {
                        var recValue = record.get(filterParams.property).toString().toLowerCase(),
                            inputValue = filterParams.value.toLowerCase();

                        return recValue.indexOf(inputValue) !== -1;
                    }
                    return false;
                }
            });

        store.filter(filter);
    }
});
