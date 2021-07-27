<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<br>
<br>
<!-- ################ accordion toggle 적용 START ################ -->
<div class="container">
   <div class="row">
      <div class="col-md-12">
         <h1>살려주세요</h1>

         <hr>
      </div>

      <div class="col-md-12">
         <div class="panel-group" id="accordion" role="tablist"
            aria-multiselectable="true">
            <c:forEach var="list" items="${vlist}">
            <c:set var="count" value="${count = count + 1}"/>
      <form id="flightFrm1" name="flightFrm1" action="/vaccine/vacmap" method="get">
            
               <div class="panel-heading" role="tab" id="heading${count}">
                  <h4 class="panel-title">
                     <span style="float: left;">&nbsp;<br>
                        ${list.orgnm}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  </span> 
                  </h4>
               </div>
                        
               <div id="collapse${count}" class="panel panel-default" 
                  style="margin-top: 10px; margin-bottom: 10px;"  role="tabpanel" aria-labelledby="heading${count}">
                  <div class="panel-heading" role="tab" id="heading${count}">
                     <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse"
                           data-parent="#accordion" href="#collapse${count}"
                           aria-expanded="true" aria-controls="collapse${count}"> </a>
                     </h4>
                  </div>
                  <table class="table table-striped" style="margin-top: 10px;">
                     <thead>
                        <tr>
                           <th>기관코드</th>
                           <th>기관명</th>
                           <th>기관전화번호</th>
                           <th>기관 주소</th>

                        </tr>

                     </thead>
                     <tbody>
                        <tr>
                           <td>${list.orgcd}</td>
                           <td>${list.orgnm}</td>
                           <td>${list.orgTlno}</td>
                           <td id="ddd">${list.orgZipaddr}</td>
                        <td><input type="hidden"  name="orgZipaddr" id="orgZipaddr" value="${list.orgZipaddr}"></td>
                            <td><input type="button"   id="input_submit" onclick="input()" value="조회"></td>
                        </tr>
                     
                            
                     </tbody>
                  </table>
            
               </div>
</form>
            </c:forEach>

         </div>
      </div>
   </div>
</div>
<br>

<script type="text/javascript">
   
function input() {
   var dday = document.getElementById('orgZipaddr');

   console.log(dday);
   $('#flightFrm1').submit();
}
      
   </script>



<%@ include file="../layout/footer.jsp"%>