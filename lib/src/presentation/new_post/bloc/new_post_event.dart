abstract class NewPostEvent {}

class CreatePostEvent extends NewPostEvent {
  String description;
  List<String> photo;

  CreatePostEvent(this.description, this.photo);
}

class UpdatePostEvent extends NewPostEvent {
  String id;
  String description;
  List<String> photo;

  UpdatePostEvent(this.id, this.description, this.photo);
}
