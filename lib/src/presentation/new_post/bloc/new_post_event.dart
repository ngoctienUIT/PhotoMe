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
  List<String> deletePhoto;

  UpdatePostEvent({
    required this.id,
    required this.description,
    required this.photo,
    required this.deletePhoto,
  });
}

class ChangeImageListEvent extends NewPostEvent {}
