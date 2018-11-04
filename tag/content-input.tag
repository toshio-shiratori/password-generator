<content-input>

  <div class="area-kind">
    使う文字の種類
    <hr>
    <ul>
      <ol each={ items }>
        <label class={ completed: done }>
          <input type="checkbox" checked={ done } onclick={ parent.toggle }> { title }
        </label>
      </ol>
    </ul>
  </div>

  <style>
    :scope .area-kind {
      border: solid 1px black;
      margin: 1em;
      margin-top: 0px;
      padding: 1em;
    }  
    :scope ul {
      padding-left: 1em;
    }
    :scope ol {
      padding: 0;
      padding-bottom: 0.5em;
    }
  </style>

  <script>
    const myTagName = 'content-input'
    var self = this
    self.observer = opts.observer
    self.observer.on('destroy', function(param) {
      if (param.includes(myTagName)) {
        self.show = false
        self.update()
      }
    })

    self.items = getDefaultItems()

    toggle(e) {
      var item = e.item
      item.done = !item.done
    }

    // ミックスインでタグを超えて機能を共有
    riot.mixin('ContentInputTag', {
      // アイテム取得
      getItems: function() {
        return self.items
      },
      // アイテム初期化
      initItems: function() {
        self.items = getDefaultItems()
        self.update()
      }      
    })
  </script>

</content-input>
