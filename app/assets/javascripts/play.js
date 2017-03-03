// 問題を画面に表示させる
var setProblem = function(problem){
  // 問題文を表示させる
  $("#problem").replaceWith('<div id="problem"><h1>'+problem.problem+'</h1></div>');
  MathJax.Hub.Queue(["Typeset", MathJax.Hub, "problem"]);
  if (problem.image_url != null){
    // 画像を表示させる
    $("#image").replaceWith('<div id="image"><img src="'+problem.image_url+'" alt="problem" class="img-responsive"></div>');
  }
  // 選択肢をランダマイズする
  ary = [1,2,3,4];
  ary.sort(function(){return Math.random()-Math.random();});

  // 選択肢をアップデートする
  $('#selection'+ary[0]).replaceWith('<span id="selection'+ary[0]+'" class="answer">'+problem.answer+'</span>');
  $('#selection'+ary[1]).replaceWith('<span id="selection'+ary[1]+'" class="dummy1">'+problem.dummy1+'</span>');
  $('#selection'+ary[2]).replaceWith('<span id="selection'+ary[2]+'" class="dummy2">'+problem.dummy2+'</span>');
  $('#selection'+ary[3]).replaceWith('<span id="selection'+ary[3]+'" class="dummy3">'+problem.dummy3+'</span>');
  MathJax.Hub.Queue(["Typeset", MathJax.Hub, "buttonarea"]);
}

// 問題エリアを元に戻す。
var clearProblem = function(problem){
  // 問題文を表示させる
  $("#problem").replaceWith('<div id="problem"></div>');
  // 画像を表示させる
  $("#image").replaceWith('<div id="image"></div>');
  // 選択肢を元に戻す
  $('#parentselection1').replaceWith('<div id="parentselection1" class="btn btn-default btn-block btn-lg"><h1><span id="selection1"> </span></h1></div>');
  $('#parentselection2').replaceWith('<div id="parentselection2" class="btn btn-default btn-block btn-lg"><h1><span id="selection2"> </span></h1></div>');
  $('#parentselection3').replaceWith('<div id="parentselection3" class="btn btn-default btn-block btn-lg"><h1><span id="selection3"> </span></h1></div>');
  $('#parentselection4').replaceWith('<div id="parentselection4" class="btn btn-default btn-block btn-lg"><h1><span id="selection4"> </span></h1></div>');
  $("#ref_answer").replaceWith('<span id="ref_answer"></span>');
  $("#kekka").replaceWith('<span id="kekka"></span>');
  $("[id^=parentselection").off("click");
  $("#btngo").off("click");
  $("#btnref").off("click");
  $("#estimate_progress").progressbar({value:100});
}
// 開始ログを送る。
var sendStartlog = function(student_id,problem_id,session_id){
  // 現在時刻を取得
  response_timing = getNow();
  // ログを送信
  insertDatabase({start:{student_id:student_id,problem_id:problem_id,session_id:session_id,response_timing:response_timing}},'/starts');

}

// 見積もりログを送る。
var sendEstimatelog = function(student_id,problem_id,session_id,estimated_time){
  // 現在時刻を取得
  response_timing = getNow();
  // ログを送信
  insertDatabase({estimate:{student_id:student_id,problem_id:problem_id,session_id:session_id,estimated_time:estimated_time,response_timing:response_timing}},'/estimates');
}

// 選択ログを送る。
var sendSelectlog = function(student_id,problem_id,session_id,answer){
  // 現在時刻を取得
  response_timing = getNow();
  // ログを送信
  insertDatabase({selection:{student_id:student_id,problem_id:problem_id,session_id:session_id,answer:answer,response_timing:response_timing}},'/selections')
}

// 振り返りログを送る。
var sendReflectlog = function(student_id,problem_id,session_id,reflection){
  // 現在時刻を取得
  response_timing = getNow();
  // ログを送信
  insertDatabase({reflection:{student_id:student_id,problem_id:problem_id,session_id:session_id,reflection:reflection,response_timing:response_timing}},'/reflections');
}

// 最終解答ログを送る。
var sendAnswer = function(student_id,problem_id,session_id,answer){
  // 現在時刻を取得
  response_timing = getNow();
  // ログを送信
  insertDatabase({answer:{student_id:student_id,problem_id:problem_id,session_id:session_id,answer:answer,response_timing:response_timing}},'/answers');
}

// 現在時刻をUNIXタイムで取得する
var getNow = function(){
  var nowtime = $.now();
  return nowtime;
}

// タイムアップを表示する
var showTimeup = function(answer){
  // メッセージを表示
  $("#kekka").html("タイムアップ、残念・・・。");
  // 振り返りモーダルを隠す
  $("#reflection").modal("hide");
  // 回答モーダルを表示
  $("#answer").modal("show");
}

// 正解を表示する
var showBingo = function(){
  // メッセージを表示
  $("#kekka").html("正解！！");
  // 回答モーダルを表示
  $("#answer").modal("show");
}

// 不正解を表示する
var showMiss = function(){
  // メッセージを表示
  $("#kekka").html("残念、不正解。。。");
  // 回答モーダルを表示
  $("#answer").modal("show");
}

var playProblem = function(student_id,problem_id,session_id,timelimit,correct_num){
  // 見積もりのモーダルを閉じる
  $("#estimate").modal("hide");
  // 進んだプログレスバーの値を保存する
  var remaintime = 100;
  // 見積もりのログを送る
  sendEstimatelog(student_id,problem_id,session_id,timelimit);
  clearInterval(progressBar);
  // タイマーを開始する
  var progressBar = setInterval(function(){
    remaintime = remaintime - 1;
    $("#progress").progressbar({value: remaintime});
    if(remaintime < 0){
      clearInterval(progressBar);
      sendAnswer(student_id,problem_id,session_id,"timeup");
      showTimeup();
    }
  }, timelimit/1000);

  // 選択肢を選択したら見直しのダイアログを出す
  $("[id^=parentselection").on("click",function(){
    // 回答の種類を取得する
    selection_id = $(this).children("h1").children("[id^=selection").attr("class");
    // 回答の内容を取得する
    selection_val = $(this).children("h1").children("[id^=selection").html();
    // 見直しモーダルに回答を表示
    $("#ref_answer").replaceWith('<span id="ref_answer">'+selection_val+'</span>');
    MathJax.Hub.Queue(["Typeset", MathJax.Hub, "buttonarea"]);

    // 選択したログを送る
    sendSelectlog(student_id,problem_id,session_id,selection_id);
    // 見直しモーダル
    $("#reflection").modal("show");
  });

  // 見直し「しない」となった時に答え合わせをする
  $("#btngo").on("click",function(){
    // 見直しモーダルを隠す
    $("#reflection").modal("hide");
    // 見直しログを送信
    sendReflectlog(student_id,problem_id,session_id,false);
    // 回答を登録する
    sendAnswer(student_id,problem_id,session_id,selection_id);
    // タイマーを切る
    clearInterval(progressBar);
    // 選択したspanのidで正誤を判断する
    if (selection_id == "answer") {
      showBingo();
      var correct_num = parseInt(localStorage.getItem("correct_num"));
      localStorage.setItem("correct_num",correct_num + 1);
    } else {
      showMiss();
    }
  });

  // 見直し「する」となった時にタイマーをリスタートする
  $("#btnref").on("click",function(){
    // 見直しログを送信
    sendReflectlog(student_id,problem_id,session_id,true);
    // 見直しモーダルを閉じる
    $("#reflection").modal("hide");
  });
}

var insertDatabase = function(dataset, apipath){
  datatable = JSON.parse(localStorage.getItem("datatable"));
  datatable.push({apipath:apipath, dataset:dataset});
  localStorage.setItem("datatable",JSON.stringify(datatable));
}

var sendApi = function(dataset, apipath){
  $.ajax({
    url: apipath,
    type: 'POST',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    data:dataset
  });
}
