require 'will_paginate/array'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
      before_action :authenticate_user!, :alert_counts
def datatable_paginate (db,paramse)
  if (session[:per_pages] == nil) || (params["query"] == "")
    session.delete(:data)
    session[:per_pages] ||= 10
    @paginate = pagination(query(db,paramse),session[:per_pages])
  else
    if params["type"] == 'select'
      if params["search_query"].present?
        session[:data]= params["search_query"]
        @paginate = pagination(sql_query(params["search_query"],db,paramse,nil),params["query"])

      else
        @paginate = pagination(query(db,paramse),params["query"])

      end
    elsif params["type"] =='sorts'
      if params["search_query"].present?
        session[:data]= params["search_query"]
        aa=params["search_query"]
        param= params["sorts"]
        @paginate = pagination(sql_query(params["search_query"],db,paramse,params["sorts"]),session[:per_pages])
      else
        @paginate = pagination(sorts(db,params["sorts"],paramse),session[:per_pages])

      end
    else
      session[:data]= params["query"]
      @paginate = pagination(sql_query(params["query"],db,paramse,nil),session[:per_pages])

    end
  end
  @total = @paginate.total_entries
  respond_to do |format|
    format.js
    format.html

  end
  #return page
end


    def pagination(page,per_page)
      session[:per_pages] = per_page
      page.paginate(:page => params[:page], :per_page => session[:per_pages])
    end

    def sql_query(query,d_b,champs,sort)
      sql_search = "(#{d_b[0].to_s.classify.constantize.table_name}.#{champs[0].gsub(/;/, "  like  '#{query}%'  or  #{d_b[0].to_s.classify.constantize.table_name}.")} like '#{query}%'"
      if d_b.length >1
        dt = d_b[1 .. d_b.length]
        for i in 1..dt.length
          sql_search <<  " or #{d_b[i].to_s.classify.constantize.table_name}.#{champs[i]} like '#{query}%'"
        end
        sql_search << ')'
        if champs.last.kind_of?(Array)
          sql_search << "and (#{champs.last[1]})"
          if sort.present?
            tomp = sort.split(';')
            resultats = d_b[0].to_s.classify.constantize.left_joins(dt).where(sql_search).order("#{tomp[0]} #{tomp[1]}")
          else
            resultats = d_b[0].to_s.classify.constantize.left_joins(dt).where(sql_search)
          end
        elsif sort.present?
          tomp = sort.split(';')
          resultats = d_b[0].to_s.classify.constantize.left_joins(dt).where(sql_search).order("#{tomp[0]} #{tomp[1]}")
        else
          resultats = d_b[0].to_s.classify.constantize.left_joins(dt).where(sql_search)
        end
      elsif sort.present?
        if champs.last.kind_of?(Array)
          sql_search << ")and (#{champs.last[1]})"
        else
          sql_search << ")"
        end
        tomp = sort.split(';')
        sql_search << " ORDER BY   #{d_b[0].to_s.classify.constantize.table_name}.#{tomp[0]} #{tomp[1]}"
        resultats = d_b[0].to_s.classify.constantize.find_by_sql ("SELECT * FROM #{d_b[0].to_s.classify.constantize.table_name} WHERE   #{sql_search};")
      else
        if champs.last.kind_of?(Array)
          sql_search << ") and (#{champs.last[1]})"
        else
          sql_search << ") "
        end
        resultats = d_b[0].to_s.classify.constantize.find_by_sql ("SELECT * FROM #{d_b[0].to_s.classify.constantize.table_name} WHERE   #{sql_search};")
      end
      return resultats
    end

    def query(db,param)
      if param.last.kind_of?(Array)
        if db[0].to_s.classify.constantize.table_name != param.last[0]
          result = db[0].to_s.classify.constantize.left_joins(db[1]).where(param.last[1])
        else
          result = db[0].to_s.classify.constantize.where(param.last[1])
        end
      else
        result = db[0].to_s.classify.constantize
      end
      return result
    end

    def sorts(d_b,sort,champs)
      tomp = sort.split(';')
      if d_b.length >1
        dt = d_b[1 .. d_b.length]
        if champs.last.kind_of?(Array)
          resultat = d_b[0].to_s.classify.constantize.left_joins(dt).where(champs.last[1]).order("#{tomp[0]} #{tomp[1]}")
        else
          resultat = d_b[0].to_s.classify.constantize.left_joins(dt).order("#{tomp[0]} #{tomp[1]}")
        end
      else
        if champs.last.kind_of?(Array)
          resultat = d_b[0].to_s.classify.constantize.find_by_sql ("SELECT * FROM #{d_b[0].to_s.classify.constantize.table_name} where #{champs.last[1]} ORDER BY   #{tomp[0]} #{tomp[1]};")
        else
          resultat = d_b[0].to_s.classify.constantize.find_by_sql ("SELECT * FROM #{d_b[0].to_s.classify.constantize.table_name} ORDER BY   #{tomp[0]} #{tomp[1]};")
        end
      end
      return resultat
    end

  private
  def alert_counts
    @alerts = Stock.where('amount < 6').count
  end
end