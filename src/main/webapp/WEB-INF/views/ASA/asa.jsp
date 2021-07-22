<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		<main role="main" class="main-content">
		
		<div class="alert alert-primary" role="alert">지역별 확진자를 확인할 수 있습니다.</div>
		<div class="row justify-content-center">
			<div class="row">
					<!-- Recent orders -->
					
						<h6 class="mb-3">전국 확진자 한눈에 보기</h6>
						<table class="table table-borderless table-striped">
							<thead>
								<tr role="row">
									<th>지역</th>
									<th>등록 일시</th>
									<th>전체 확진자</th>
									<th>전일 대비</th>
									<th>격리중</th>
									<th>격리 해제</th>
									<th>사망자 수</th>
									<th>지역 발생</th>
									<th>해외 유입</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="alist" items="${alist}">
								<tr>
									<th scope="col">${alist.gubun}</th>
									<fmt:parseDate value="${alist.createDt}" var="dateTime" pattern="yyyy-MM-dd HH:mm:ss" />
									<td><fmt:formatDate value="${dateTime}" pattern="yyyy-MM-dd"/></td>
									<td>${alist.defCnt}</td>
									<td>+${alist.incDec}</td>
									<td>${alist.isolIngCnt}</td>
									<td>${alist.isolClearCnt}</td>
									<td>${alist.deathCnt}</td>
									<td>${alist.localOccCnt}</td>
									<td>${alist.overFlowCnt}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- / .col-md-3 -->
					</div>
			</main>
<%@ include file="../layout/footer.jsp"%>
