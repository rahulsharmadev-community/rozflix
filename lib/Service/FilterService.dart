import 'package:rozflix/MovieData.dart';

class FilterService {
  List<MovieData> categoryFilter(List<MovieData> data, String _category) {
    List<MovieData> filerdata = [];
    data.forEach((element) {
      if (element.category.any((categorys) =>
          categorys.trim().toLowerCase() == _category.toLowerCase()))
        filerdata.add(element);
    });
    return filerdata;
  }

  List<MovieData> typeFilter(List<MovieData> data, String _type) {
    List<MovieData> filerdata = [];
    data.forEach((element) {
      if (element.type.toLowerCase() == _type.toLowerCase())
        filerdata.add(element);
    });
    return filerdata;
  }

  List<MovieData> ratingFilter(List<MovieData> data,
      {bool isAccendingtrue = true}) {
    List<MovieData> filerdata = [];
    filerdata.addAll(data);
    var temp;
    int n = data.length;
    if (isAccendingtrue)
      for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
          if (filerdata[i].rating < filerdata[j].rating) {
            temp = filerdata[i];
            filerdata[i] = filerdata[j];
            filerdata[j] = temp;
          }
        }
      }
    else
      for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
          if (filerdata[i].rating > filerdata[j].rating) {
            temp = filerdata[i];
            filerdata[i] = filerdata[j];
            filerdata[j] = temp;
          }
        }
      }

    return filerdata;
  }

  List<MovieData> searchFilter(List<MovieData> data, String _title) {
    List<MovieData> filerdata = [];
    data.forEach((element) {
      if ((element.name.toLowerCase()).contains(_title.toLowerCase()))
        filerdata.add(element);
    });
    return filerdata;
  }
}
