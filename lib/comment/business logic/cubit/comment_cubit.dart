import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/comment_model.dart';
import '../../data/repo_impl/comment_repo_impl.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepoImpl commentRepo;
  CommentCubit(this.commentRepo) : super(CommentLoadingState());

  loadedComments()async{
    try{
      emit(CommentLoadingState());
      var comments=await commentRepo.getComment();
      emit(CommentLoadedState(comments));
    }
    catch(e){
      emit(CommentErrorState(e.toString()));
    }
  }

  addComment(CommentModel comment)async{
      CommentModel? res = await commentRepo.addComment(comment);
      if(res != null){
        List<CommentModel> oldComments = (state is CommentLoadedState) ? (state as CommentLoadedState).comments : [];
        emit(CommentLoadedState( [res,...oldComments]));
      }
  }

}
