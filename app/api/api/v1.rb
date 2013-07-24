module API

class V1 < Grape::API

  # version 'v1', using: :header, vendor: 'todomvc'
  version 'v1', using: :path
  format :json
  default_format :json

  helpers do

    def prepare_attrs(params)
      attrs = {
        title: params[:title],
        completed: params[:completed]
      }
      attrs.delete_if {|k, v| v.nil?}
      attrs
    end

  end

  resources :tasks do

    desc 'Tasks list'
    get do
      Task.all
    end

    desc 'Task show'
    params do
      requires :id, type: Integer, desc: 'Task Id'
    end
    route_param :id do
      get do
        Task.find(params[:id])
      end
    end

    desc 'Task create'
    params do
      requires :title, type: String, desc: 'Task title'
      optional :completed, type: Boolean, default: false, desc: 'Task completed flag'
    end
    post do
      attrs = prepare_attrs(params)
      Task.create(attrs)
    end

    desc 'Task update'
    params do
      requires :id, type: Integer, desc: 'Task Id'
      optional :title, type: String, desc: 'Task title'
      optional :completed, type: Boolean, desc: 'Task completed flag'
    end
    put ':id' do
      attrs = prepare_attrs(params)
      Task.find(params[:id]).update(attrs)
    end

    desc 'Task delete'
    params do
      requires :id, type: Integer, desc: 'Task Id'
    end
    delete ':id' do
      Task.find(params[:id]).destroy
    end

  end

end

end
