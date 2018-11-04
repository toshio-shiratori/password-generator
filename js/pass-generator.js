/**
 * デフォルトのパスワード長さ取得
 */
function getDefaultPasswordLen() {
  return 8
}

/**
 * デフォルトのパスワード文字種取得
 */
function getDefaultItems() {
  var items = [
    {
      title: "大文字",
      id: "useUpper",
      done: true
    },
    {
      title: "小文字",
      id: "useLower",
      done: true
    },
    {
      title: "数字",
      id: "useNumber",
      done: true
    },
    {
      title: "記号",
      id: "useSymbol",
      done: false
    }
  ]

  return items
}

function getApiParams(items, passwordLen) {
  var options = []
  items.forEach(function(item) {
    var record = null;
    switch(item.id) {
      case 'useUpper':
        record = { "useUpper": item.done };
        break;
      case 'useLower':
        record = { "useLower": item.done };
        break;
      case 'useNumber':
        record = { "useNumber": item.done };
        break;
      case 'useSymbol':
        record = { "useSymbol": item.done };
        break;
    }
    if(record != null) {
      options.push(record);
    }
  });
  var params = {
    "plen": passwordLen,
    "options": options
  }
  return params
}