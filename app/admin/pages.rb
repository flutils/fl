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

     menu priority: 3, label: -> { ['🚀', model.constantize.model_name.human(count: 2)].join(' ') }

    ##################################
    ##################################

    # => Strong Params
    permit_params :slug, :ref, :val

    ##################################
    ##################################



    ##################################
    ##################################

    # =>  Form
    form do |f|
      f.inputs 'Details' do
        f.input :slug
        f.input :ref
        f.input :val, as: :ckeditor
      end

      f.actions
  	end

    ##################################
    ##################################


  end

  ############################################################
  ############################################################

end