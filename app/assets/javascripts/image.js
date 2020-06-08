
$(function(){
  var dataBox = new DataTransfer();
  var file_field = document.getElementById('img-file')
  $('#append-js').on('change','#img-file',function(){
    // var files = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();
      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      var num = $('.item-image').length + 1 + i
      var aaa = $('.item-image').length + i
      var image_value = $('.img-label').prev().attr('id')
      var id = Number(image_value)
      var input_value = $('#append-js').children('div').last().children('input').attr('value')
      var value = Number(input_value)
      console.log(value)
      fileReader.readAsDataURL(file);
     //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 10){
        $('#image-box__container').css('display', 'none')
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `<div class='item-image' data-image="${file.name}" data-index="${aaa}" id="${id+1}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="188" height="180" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`
        const buildFileField = (num)=> {
          const html = `<div  class="js-file_group" data-index="${num}">
                          <input class="js-file" type="file"
                          name="item[images_attributes][${num}][image]"
                          id="img-file" data-index="${num}" value="${value+1}">
                        </div>`;
          return html;
        }
        $('.js-file').removeAttr('id');
        //image_box__container要素の前にhtmlを差し込む
        $('.img-label').before(html);
        // $('#image-box__container').before(buildFileField(num))
        $('#append-js').append(buildFileField(num));
      };
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#image-box__container').attr('class', `item-num-${num}`)
      // $('#img-file').attr('name', `item[images_attributes][${num}][image]`)
    });
  });
  $(document).on("click", '.item-image__operetion--delete', function(){
    //削除を押されたプレビュー要素を取得
    var target_image = $(this).parent().parent();
    //削除を押されたプレビューimageのfile名を取得
    var target_index = $(target_image).data('index');
    var target_file = $('[data-index="'+target_index+'"].js-file');
    //プレビューを削除
    target_image.remove()
    target_file.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num}`)
  })
  $(document).on("click", '.item-image__operetion--edit__delete', function(){
    //削除を押されたプレビュー要素を取得
    var target_image = $(this).parent().parent();
    //削除を押されたプレビューimageのfile名を取得
    var target_id = $(target_image).attr('id');
    var target_image_file = $('input[value="'+target_id+'"]');
    //プレビューを削除
    target_image.remove()
    target_image_file.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num}`)
  })
  // var dropArea = $("#img-file");
  var dropArea = $(".item-num-0");
  dropArea.on("dragenter", function(e){
    e.stopPropagation();
    e.preventDefault();
    // $(this).css('border', '4px solid #000');
  });
  //ドラッグした要素がドロップターゲットの上にある時にイベントが発火
  dropArea.on("dragover", function(e){
    e.stopPropagation();
    e.preventDefault();
    //ドロップエリアに影がつく
    // $(this).children('#image-box__container').css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'});
    $(this).css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'});
  });
  dropArea.on("dragleave", function(e){
    e.preventDefault();
    e.preventDefault();
   //ドロップエリアの影が消える
    $(this).children.css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})
  },false);
  //loadイベント発生時に発火するイベント
  window.onload = function(e){
    e.preventDefault();
    //ドラッグした要素がドロップターゲットから離れた時に発火するイベント
    dropArea[0].addEventListener("dragleave", function(e){
      e.stopPropagation()
      e.preventDefault();
    //ドロップエリアの影が消える
      $(this).css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})
    },false);
    //ドラッグした要素をドロップした時に発火するイベント
    dropArea[0].addEventListener("drop", function(e) {
      e.stopPropagation()
      e.preventDefault();
      $(this).css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'}),false;
      var files = e.dataTransfer.files;
      // var files = e.originalEvent.dataTransfer.files;
      $("#img-file")[0].files = files;
      //ドラッグアンドドロップで取得したデータについて、プレビューを表示
      $.each(files, function(i,file){
        //アップロードされた画像を元に新しくfilereaderオブジェクトを生成
        var fileReader = new FileReader();
        //dataTransferオブジェクトに値を追加
        dataBox.items.add(file)
        //lengthで要素の数を取得
        var num = $('.item-image').length + i + 1
        var aaa = $('.item-image').length + i
        //指定されたファイルを読み込む
        fileReader.readAsDataURL(file);
        // 10枚プレビューを出したらドロップボックスが消える
        if (num==10){
          $('#image-box__container').css('display', 'none')
        }
        //image fileがロードされた時に発火するイベント
        fileReader.onload = function() {
          //変数srcにresultで取得したfileの内容を代入
          var src = fileReader.result
          var html= `<div class='item-image' data-image="${file.name}" data-index="${aaa}">
                      <div class=' item-image__content'>
                        <div class='item-image__content--icon'>
                          <img src=${src} width="188" height="180" >
                        </div>
                      </div>
                      <div class='item-image__operetion'>
                        <div class='item-image__operetion--delete'>削除</div>
                      </div>
                    </div>`
          const buildFileField = (num)=> {
            const html = `<div  class="js-file_group" data-index="${num}">
                            <input class="js-file" type="file"
                            name="item[images_attributes][${num}][image]"
                            id="img-file" data-index="${num}">
                          </div>`;
            return html;
          }
        $('.js-file').removeAttr('id');
        //image-box__containerの前にhtmlオブジェクトを追加
        $('.img-label').before(html);
        $('#append-js').append(buildFileField(num));
        };
        //image-box__containerにitem-num-(変数)という名前のクラスを追加する
        $('#image-box__container').attr('class', `item-num-${num}`)
      })
    })
  }
    // windowにdropした時の挙動をキャンセル
    $(document).on("dragenter", function(e){
      e.stopPropagation();
      e.preventDefault();
    });
    $(document).on("dragover", function(e){
      e.stopPropagation();
      e.preventDefault();
    });
    $(document).on("drop", function(e){
      e.stopPropagation();
      e.preventDefault();
    });
});