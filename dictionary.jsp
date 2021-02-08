<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>NOMU</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="<c:url value='/'/>css/reset.css" type="text/css">
        <link rel="stylesheet" href="<c:url value='/'/>css/dict.css" type="text/css" >
        
    <script src="http://code.jquery.com/jquery-1.11.0.js"> </script>
	<%@ include file="../../includes/header.jsp" %>
    <div class="dic1">
      <div class="inputarea">
        <input class="searchbar" type="text" placeholder="검색어를 입력해주세요">
        <button class="searchBtn" type="button"><img src="images/nomu/search_icon.png" alt="search_icon"></button>
      </div>
  </div>
    <main class="container">
        <div class="dic2">
          <div class="dic_category">
              <table class="dic_table">
                  <tbody><tr>
                      <!-- <td>
                          <strong>개인연금</strong>
                          <p>
                              생명 보험 회사나 신탁 은행이 개인에게 상품으로 판매하는 연금 지불형의 보험이나 신탁,
                              개인이 보험 회사나 은행에 일정액을 불입한 후 일정한 나이가 되면
                              해마다 일정액을 지급받는다
                          </p>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <strong>계약일</strong>
                          <p>
                              건설에서, 시공주와의 계약이 체결된 일자, 자기 공사인 경우에는 착공일자를 계약일자로 본다.
                          </p>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <strong>실업급여</strong>
                          <p>
                              경제정부, 고용인, 피고용자가 공동으로 비용을 분담하는 사회 보험 제도의 하나, 근로자가
                              실직할 경우 일정 금액 지급을 받는것으로, 1996년 7월부터 실시되었다. 구직급여, 상병급여,
                              취직촉진수당, 연장급여로 구분된다
                          </p>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <strong>연금</strong>
                          <p>
                              국가나 사회에 특별한 공로가 있거나 일정기간동안 국가기관에 복무한 사람에게 해마다 주는 돈, 무상연금
                          </p>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <strong>고용보험</strong>
                          <p>
                              근로자가 실직한 경우에 생활안정을 위하여 일정기간 동안 급여를 지급하는 실업급여사업과 함께 구직자에 대한 직업능력개발·향상 및 적극적인 취업알선을 통한 재취업의 촉진과 실업예방을 위하여 고용안정사업 및 직업능력개발사업 등의 실시를 목적으로 하는 사회보험의 하나
                      </p></td> -->
                  </tr>
              </tbody></table>
              <div class="paging" id="paging">
                <ul>
              </ul>
              </div>
          </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </main>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
    
    <script type="text/javascript">

    var pager = function (options) {

        var defaults = {
            currentPage: 1 // 현재페이지    
            , pageSize: 5 // 페이지 사이즈 (화면 출력 페이지 수)
            , maxListCount: 5 // (보여질)최대 리스트 수 (한페이지 출력될 항목 갯수)
            , startnum: 1 // 시작 글번호
            , lastnum: 5 // 마지막 글번호
            , totalCnt: 0 // 전체 글의 갯수.
            , totalPageCnt: 0 // 전체 페이지 수

        };

        this.buttonClickCallback = null;
        this.opts = $.extend({}, defaults, options);

    };

    pager.prototype = {

        "renderpager": function (totalCnt, buttonClickCallback) {

            //console.log(this);
            //console.log(this.opts);
            var _ = this;

            _.opts.totalCnt = totalCnt; //토탈 카운트 객체 멤버변수에 저장.

            var pageSize = this.opts.pageSize;
            var maxListCount = this.opts.maxListCount;
            var currentPage = this.opts.currentPage;

            if (totalCnt == 0) {
                return "";
            }

            //총페이지수 구하기 : 페이지 출력 범위 (1|2|3|4|5)
            var totalPageCnt = Math.ceil(totalCnt / maxListCount);

            //현재 블럭 구하기 
            var n_block = Math.ceil(currentPage / pageSize);

            //페이징의 시작페이지와 끝페이지 구하기
            var s_page = (n_block - 1) * pageSize + 1; // 현재블럭의 시작 페이지
            var e_page = n_block * pageSize; // 현재블럭의 끝 페이지

            // setup $pager to hold render
            var $pager = $('#paging'); // TODO: 페이지를 출력할 영역. ( 출력할 영역의 ID를 인자로..  )
            $pager.empty(); //영역에 기존에 있던 내용 제거


            //처음, 이전 버튼 추가
            $pager.append(this.renderButton('first', totalPageCnt, _.buttonClickCallback))
                .append(this.renderButton('prev', totalPageCnt, _.buttonClickCallback));

            //페이지 나열
            for (var j = s_page; j <= e_page; j++) {
                if (j > totalPageCnt) break;

                var currentButton = $('<li >' + (j) + '</li>');

                //현재 페이지일경우 select 클래스 추가. 
                if (j == currentPage) currentButton.addClass('selected');
                else currentButton.click(function () {
                    _.initNum(parseInt(this.firstChild.data));
                    _.buttonClickCallback(this.firstChild.data);
                });

                currentButton.appendTo($pager); //페이징 영역에 버튼 추가            
            }

            //다음, 마지막 버튼 추가
            $pager.append(this.renderButton('next', totalPageCnt, _.buttonClickCallback))
                .append(this.renderButton('last', totalPageCnt, _.buttonClickCallback));

            return $pager;
        },
        "initNum": function (cp) {

            this.opts.currentPage = cp;

            //시작 글번호
            this.opts.startnum = (cp - 1) * this.opts.maxListCount + 1;

            // 마지막 글번호
            var tmp = cp * this.opts.maxListCount;
            this.opts.lastnum = (tmp > this.opts.totalCnt ? this.opts.totalCnt
                : tmp);

            // console.log("P:" + cp + "/startnum:" + this.opts.startnum + "/lastnum:" + this.opts.lastnum);

        },

        "renderButton": function (buttonLabel, totalPageCnt,
            buttonClickCallback) {
            var _ = this;
            var currentPage = this.opts.currentPage;
            //var totalPageCnt = this.opts.totalPageCnt;

            var $Button = $('<li >' + buttonLabel + '</li>');
            var destPage = 1;

            // work out destination page for required button type
            switch (buttonLabel) {
                case "first":
                    destPage = 1;
                    $Button.addClass('active');
                    $Button.html('<<');
                    break;

                case "prev":
                    destPage = currentPage - 1;
                    $Button.addClass('active');
                    $Button.html('이전');
                    break;

                case "next":
                    destPage = currentPage + 1;
                    $Button.addClass('active');
                    $Button.html('다음');
                    break;

                case "last":
                    destPage = totalPageCnt;
                    $Button.addClass('active');
                    $Button.html('>>');
                    break;
            }

            // disable and 'grey' out buttons if not needed.
            if (buttonLabel == "first" || buttonLabel == "prev") { //1페이지에서는 처음, 이전 버튼 안보이게 

                if (currentPage <= 1) $Button.addClass('pgEmpty').css("display", "none")
                else $Button.click(function () { _.initNum(destPage); buttonClickCallback(); });
            } else {
                if (currentPage >= totalPageCnt) $Button.addClass('pgEmpty').css("display", "none")
                else $Button.click(function () { _.initNum(destPage); buttonClickCallback(); });
            }
            return $Button; //생성된 버튼 반환
        }
    };

    function onClickAsEnter(e) {
        if (e.keyCode === 13) {
            onSendButtonClicked()
        }
    }




    var page = new pager();
    $.ajax({
        url: "http://192.168.0.11:5000/nomu_dict",
        type: "GET",
        dataType: "json",
        error: function (request, status, error) {
            console.log("연결실패")
        }
    }).done(function (data) {
        nomu_dict = data['nomu_dict'];
        page.buttonClickCallback = listContent;


        function searchingDict(){
            search_key = $('.searchbar').val();
            result = [];
            $(".dic_table tr").empty();
            nomu_dict.forEach(function (item, index, arr2) {
                search_str = item['word_name'] + item['word_descriptions'];
                if (search_str.includes(search_key)) {
                    result.push(item);
                }
            });
            for (let i = 0; i < result.length; i++) {
                $(".dic_table").append("<tr><td><strong>"+result[i]['word_name']+"</strong><p>"+result[i]['word_descriptions']+"</p></td></tr>");
            }
        }
        $(".searchbar").keyup(function (e) {
            if (e.keyCode == 13) {
                searchingDict();
            }
        });

        $('.searchBtn').click(function () {
            searchingDict();
        });


        function listContent() {
            $(".dic_table tr").empty();
            page.renderpager(nomu_dict.length);
            listCnt = page['opts']['maxListCount'];
            startnum = page['opts']['startnum'];
            lastnum = page['opts']['lastnum'];

            for (let i = startnum - 1; i < lastnum; i++) {
                $(".dic_table").append("<tr><td><strong>"+nomu_dict[i]['word_name']+"</strong><p>"+nomu_dict[i]['word_descriptions']+"</p></td></tr>");
            }

        }
        listContent();
    })

    
    </script>
</body>
</html>