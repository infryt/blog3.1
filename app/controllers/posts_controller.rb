class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :check_author, only: [:edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
 if session[:user_id] == nil
      redirect_to root_url, flash[:notice] => "logeate primero"
    end
    else
    @posts = Post.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
     respond_to do |format|
     format.html # show.html.erb
      format.xml  { render :xml => @article }
      format.json { render :json => @article }
      end
end
  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
     format.html # show.html.erb
      format.xml  { render :xml => @article }
      format.json { render :json => @article }
   end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @user = User.find(session[:user_id])
    @post.user = @user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #checar autor para editar
  def check_author
    if session[:user_id] != @post.user_id
      redirect_to posts_path,:notice => "si no es tuyo no lo puedes editar"
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :titulo, :body, :photo)
    end
    def user_params
      params.require(:post).permit(:uid, :user_id, :name)
    end
  end 

