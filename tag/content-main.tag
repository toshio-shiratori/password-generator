<content-main>

  <div>
    <label>パスワード：
      <input type="text" size="20" value={ password } readonly="" ref="pwOut">
    </label>
    <br>
    <button type="button" onclick={ create }>{ createMsg }</button>
    <button type="button" onclick={ reset }>{ resetMsg }</button>
    <hr>
    <label>桁数：
      <input type="number" min="1" max="99" value={ passwordLen } oninput={ checkLen } style="width: 3em;" ref="pwNum">
    </label>
  </div>

  <style>
    :scope button {
      margin-right: 1em;
    }
    :scope input, select, textarea {
      font-family : 'Lucida Console', sans-serif;

      font-size : 100%;
      padding-left: 4px;
    }
    :scope div {
      margin-left: 1em;
    }
  </style>

  <script>
    const myTagName = 'content-main'
    var self = this
    self.observer = opts.observer
    self.observer.on('destroy', function(param) {
      if (param.includes(myTagName)) {
        self.show = false
        self.update()
      }
    })

    self.createMsg = '実行'
    self.resetMsg = 'リセット'
    self.passwordLen = getDefaultPasswordLen()

    create() {
        self.passwordLen = self.refs.pwNum.value
        var items = self.mixin('ContentInputTag').getItems()
        var param = getApiParams(items, self.passwordLen)

        fetch('https://api.sastd.com/api/generate/password',{
          headers: {
            'content-type': 'application/json'
          },
          method: 'POST',
          mode: 'cors',
          body: JSON.stringify(param)
        })
        .then(function(data) {
          return data.json()
        })
        .then(function(json) {
          self.password = json.password
          self.update()
        })
        .catch((error) => console.log(error));
    }

    reset() {
      self.passwordLen = getDefaultPasswordLen()
      self.mixin('ContentInputTag').initItems()
      self.refs.pwNum.value = self.passwordLen
      self.refs.pwOut.value = ''
    }

    checkLen() {
      plen = self.refs.pwNum.value
      if (plen == '') {
        self.refs.pwNum.value = ''
      }
      else if (plen < 1 || 99 < plen) {
        self.refs.pwNum.value = self.passwordLen
      }
      self.passwordLen = self.refs.pwNum.value
    }
  </script>

</content-main>
