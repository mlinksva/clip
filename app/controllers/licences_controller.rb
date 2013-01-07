class LicencesController < ApplicationController
  def index
    table_cols = Licence.columns.map(&:name)
    filters = params.dup.keep_if{|key,val| table_cols.include? key }
    filters.each do |key,val|
      filters[key] = true if val == "true"
      filters[key] = false if val == "false"
      filters[key] = val.split(',') if val.include? ','
    end

    @licences = Licence.all(conditions: filters )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @licences }
    end
  end

  def show
    @licence = Licence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @licence }
    end
  end

  def new
    @licence = Licence.new
    @licence.build_compliance
    @licence.build_right
    @licence.build_obligation
    @licence.build_patent_clause
    @licence.build_attribution_clause
    @licence.build_copyleft_clause
    @licence.build_compatibility
    @licence.build_termination
    @licence.build_changes_to_term
    @licence.build_disclaimer
    @licence.build_conflict_of_law

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @licence }
    end
  end

  def edit
    @licence = Licence.find(params[:id])
  end

  def create
    @licence = Licence.new(params[:licence])

    respond_to do |format|
      if @licence.save
        format.html { redirect_to @licence, notice: 'Licence was successfully created.' }
        format.json { render json: @licence, status: :created, location: @licence }
      else
        format.html { render action: "new" }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @licence = Licence.find(params[:id])

    respond_to do |format|
      if @licence.update_attributes(params[:licence])
        format.html { redirect_to @licence, notice: 'Licence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @licence = Licence.find(params[:id])
    @licence.destroy

    respond_to do |format|
      format.html { redirect_to licences_url }
      format.json { head :no_content }
    end
  end

  def new_preview
    @licence = Licence.new(params[:licence])

    respond_to do |format|
      format.json { render json: @licence }
    end
  end

  def edit_preview
    @licence = Licence.find(params[:id])
    @licence.attributes = params[:licence]

    respond_to do |format|
      format.json { render json: @licence }
    end
  end
end
