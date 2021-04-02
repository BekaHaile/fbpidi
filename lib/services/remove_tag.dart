class RemoveTag {
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    RegExp exp2 = RegExp(r"\&nbsp;*", multiLine: true, caseSensitive: true);
    String replaced = htmlText.replaceAll(exp, '');
    replaced = replaced.replaceAll(exp2, ' ');

    return replaced;
  }
}
