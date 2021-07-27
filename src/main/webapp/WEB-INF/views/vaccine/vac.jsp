<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

 <link rel="stylesheet"  href="https://www.seoul.go.kr/res_newseoul/css/reset.css?20200515">
  <link rel="stylesheet"  href="https://www.seoul.go.kr/res_newseoul/css/corona_vaccine.css?20210702">
  <link rel="stylesheet" href="https://www.seoul.go.kr/res_newseoul/css/jquery-ui.min.css">

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="/res_newseoul/js/jquery-1.12.2.min.js"></script>
  <script src="/res_newseoul/js/jquery-ui.min.js"></script>
  <script src="/res_newseoul/js/comapp.js?20200211164103"></script>
  <script src="/res_newseoul/js/corona_vaccine_center_v14.js?v=210702"></script>

  



<main role="main" class="main-content">
 <div class="alert alert-primary" role="alert">전국 백신접종 병원을 확인할 수 있습니다.&nbsp;&nbsp;</div>

<div id="wrap"   class="support-sub ver3">
      <div id="container">
      <div class="layout-inner layout-cont layout-cont-center">
         
         <div class="vaccine-cont">

      

            <!--// .column-level3 -->

            <div class="column column-level2 column-level2-center">
               <div class="column2">
                  <dl>
                     <dt><span>거주지</span></dt>
                     <dd>
                        <form id="flightFrm" name="flightFrm" action="/vaccine/vac2" method="get">
                        <div class="label-group label-group-level2">
         <h4>시/구/군 까지입력해주세요.</h4>
                           <select class="cs-select cs-skin-border" id="from_place"
            name="from_place" required="required">
            <option value="" disabled selected>시.도 선택</option>
            <option value="서울특별시">서울특별시</option>
            <option value="경기도">경기도</option>   
            <option value="인천광역시">인천광역시</option>
            <option value="강원도">강원도</option>
            <option value="세종특별자치구">세종</option>
            <option value="충청남도">충청남도</option>
            <option value="충청북도">충청북도</option>
            <option value="대전광역시">대전광역시</option>
            <option value="대구광역시">대구광역시</option>
            <option value="경상북도">경상북도</option>
            <option value="울산광역시">울산광역시</option>
            <option value="부산광역시">부산광역시</option>
            <option value="전라북도">전라북도</option>
            <option value="전라남도">전라남도</option>
            <option value="경상남도">경상남도</option>
            <option value="광주광역시">광주광역시</option>
            <option value="제주">제주도</option>
         </select>
         <br>
         
   
          <input type="text" id="vapdo" name="vapdo" placeholder="시/구/군 을 입력해주세요 ex)수원시 팔달구(시 와 구까지 적어주세요)"> <br>
         <input    type="text" id="vapdog"   name="vapdog" placeholder="읍/면/동/리 를 입력해주세요 ex)신월동(동 까지 적어주세요)">
         
         
                        </div>
            <div class="btn-group">
               <button type="button" id="input_submit"  onclick="input()"class="btn btn-result">결과보기</button>
            </div>
                        </form>
                     </dd>
                  </dl>
               </div>
            </div>
            <!--// .column-level2 -->

            

            

            <!-- START : 결과보기 -->
            

         </div>
         <!--// .vaccine-cont -->
      </div>
      <!--// .layout-cont -->      
   </div>
   <!--// #container -->

   

</div>
<!--// support-sub -->
</main>

<script type="text/javascript">
   function input() {
      const dday = document.querySelector("#from_place").value;
      if($.trim($('#from_place').val()) === "") {
          $('#from_place').focus();
         alert("시.도 를 선택해주세요.");
      }else if($.trim($('#vapdo').val()) === "") {
          $('#vapdo').focus();
         alert("시/구/군을 입력해주세요.");
      }else{
      console.log(dday);
      $('#flightFrm').submit();
   }
   }
</script>

<%@ include file="../layout/footer.jsp"%>