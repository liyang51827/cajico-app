class Strings {
  Strings._() {
    throw AssertionError('private constructor');
  }
  // common
  static const ok = 'OK';
  static const cancel = 'キャンセル';
  static const close = '閉じる';
  static const loginText = 'ログイン';
  static const logoutLabel = 'ログアウト';
  static const favoriteText = 'お気に入り';
  static const pushSettingsLabel = 'PUSH通知設定';
  static const inviteApp = '友達に紹介する';
  static const userGuideAndFaqLabel = 'ご利用ガイド/FAQ';
  static const debugMenu = 'デバッグメニュー';
  static const nextText = '次へ';
  static const myPage = 'マイページ';
  static const termsOfUse = 'アプリ利用規約';
  static const termsOfUseApproval = 'に同意する';
  static const termsOfUseDescription = '最後までお読みいただき、同意いただける場合は「同意する」ボタンをタップして利用を開始してください。';
  static const beforeDayText = '日前';
  static const beforeMonthText = 'ヶ月前';
  static const beforeOneYearsText = '1年以上前';
  static const beauticianText = '施術者';
  static const snackbarTitleInfo = 'information';
  static const downloadingMessage = 'ダウンロード中';
  static const canceledMessage = 'キャンセルされました';
  static const retry = '再試行';

  // errors
  static const apiError = 'エラーが発生しました';
  static const parseError = 'APIレスポンスのパースに失敗しました';
  static const launchUrlError = 'URLが開けませんでした';
  static const downloadError = 'ダウンロードに失敗しました';
  static const requireNotBlank = '必ず入力してください';
  static const fullWidthCharExist = 'メールアドレスは半角入力のみ有効です。またスペースが入っていないかご確認ください。';
  static const notEmailError = 'メールアドレスは半角入力のみ有効です。またスペースが入っていないかご確認ください。';
}
