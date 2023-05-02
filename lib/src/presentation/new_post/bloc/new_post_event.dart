abstract class NewPostEvent {}

class CreatePostEvent extends NewPostEvent {
  String description;
  List<String> photo;

  CreatePostEvent(this.description, this.photo);
}
