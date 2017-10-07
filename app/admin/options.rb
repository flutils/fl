############################################################
############################################################

## Vars ##
item  = File.basename(__FILE__, ".*").singularize.titleize
model = ["Meta", item].join("::")

## Check ##
unless (model.constantize rescue nil).nil?

############################################################
############################################################

  ActiveAdmin.register model.constantize, as: item.to_s do

    ##################################
    ##################################

    # => Menu
    menu priority: 2, label: -> { ['🔒', model.constantize.model_name.human(count: 2)].join(' ') }

    # => Strong Params
    permit_params :slug, :ref, :val

    ##################################
    ##################################

    # => Index
    index do
      selectable_column
      column :ref
      column :val
      column :created_at
      column :updated_at
      actions
    end

    ##################################
    ##################################

  end

############################################################
############################################################

end
