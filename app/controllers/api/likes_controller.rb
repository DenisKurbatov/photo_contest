module Api
  class LikesController < ApiController

    def create
      @photo = Photo.find(params[:photo_id])
      @user = User.find_by(access_token: request.headers[:token])
      
      if @photo.user_id == @user.id
        render json: { message: "You don`t like your photo" }, status: 403
      elsif Like.find_by(user_id: @user.id, photo_id: @photo.id)
        render json: { message: "Like alredy exist" }, status: 409
      else
        Like.create(photo: @photo, user: @user)
        render json: { message: "Like created!" }, status: 201
      end
      
    end

    def destroy
      @photo = Photo.find(params[:photo_id])
      @user = User.find_by(access_token: request.headers[:token])
      @like = Like.find_by(user_id: @user.id, photo_id: @photo.id)
      if @photo.user_id == @user.id
        render json: { message: "It`s your photo!" }, status: 403
      elsif @like
        @like.destroy!
        render json: { message: "Like deleted!" }, status: 200
      else
        render json: { message: "Like don`t exist" }, status: 404
      end      
    end
  end
end