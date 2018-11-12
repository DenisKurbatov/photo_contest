module Api
  class LikesController < ApiController

    def create
      @photo = Photo.find(params[:id])
      @user = User.find_by(access_token: request.headers[:token])
      
      if @photo.user_id == @user.id
        result = "Can not like your photo"
      elsif Like.find_by(user_id: @user.id, photo_id: @photo.id)
        result = "Like already exists"
      else
        Like.create(photo: @photo, user: @user)
        result = "Like created!"
      end
      render json: {message: result}
    end

    def destroy
      @photo = Photo.find(params[:id])
      @user = User.find_by(access_token: request.headers[:token])
      @like = Like.find_by(user_id: @user.id, photo_id: @photo.id)
      if @photo.user_id == @user.id
        result = "It`s your photo!"
      elsif @like
        @like.destroy!
        result = "Like deleted!"
      else
        result = "Like don`t exist!"
      end
      render json: {message: result}
        
    end
  end
end