<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Jobs</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/searchResults.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="/css/jobs.css" media="screen" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

		<div class="navwrapper navLI">
		
			<div class="nav">

				<div class="nav1">

					<p class="llogo">
						Lonked<span>in</span>
					</p>
					<form class="searchForm" action="/search" method="POST">
						<input class="search" name="search" type="text"
							placeholder="Search Users"> 
						<input class="searchSubmit"
							type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2 smHide">
					<div class="icons">
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
							<img class="fafa" src="/images/home.png" alt="home"  title="Home">
						</a> <a href="/jobs"> <img class="icon-box fafa"
							src="/images/friendsI_Icon.jpg" alt="logo" title="Jobs"/>
						</a> <a class="icon-box" href="/connections/${sessionScope.user_id}">
							<img class="fafa" src="/images/friends2.png" alt="friends" title="Friends"/>
						</a> <a class="icon-box" href="/skill"> <img class="fafa"
							src="/images/chost.png" alt="skills" title="Skills" />
						</a>
					</div>
				</div>
				<div class="nav3 smHide">
					<a class="links faq" href="/about">FAQ</a>
					<a class="links logout" href="/logout">Lonkout</a>
				</div>
				
				<div class="dropdown lgHide">
					<div class="hamburger">
					    <div></div>
					    <div></div>
					    <div></div>
					</div>
                     <div class="ddlinks">
						<a class="ddlink" href="/dashboard/${ sessionScope.user_id }">Dashboard</a>
						<a class="ddlink" href="/jobs">Jobs</a>
						<a class="ddlink" href="/connections/${sessionScope.user_id}">Connections</a>
						<a class="ddlink" href="/skill">Skills</a>
						<a class="ddlink" href="/about">FAQ</a>
						<a class="ddlink" href="/logout">Lonkout</a>
                     </div>
                 </div>

			</div>

		</div>

		<div class="navSpacer navLISpacer"></div>
		<!-- JOB FORMS -->
		<!-- JOB LISTINGS -->
		<div class="jobContainer gameContainer">
			<p class="back"><a href="/jobs">All Jobs</a></p>
			<div class="gameHeader">
				<h1>${ game.name }</h1>
				<p>CEO: ${ceo !=null ? ceo.name : " Position Available!"}</p>
			</div>
			
			<div class="aboutGame">
				<h4>About ${ game.name }:</h4>
				<p>Mission Statement: ${game.description}</p>
				<p>Total Employees: ${game.getCharacters().size()}</p>
				<p>Connections Here: ${ connections }</p>
			</div>
		
			<div class="jobListings">
				<!-- For loops for displaying current available jobs -->
				<div class="currentJob">
					<div>
						<h3 style="color:grey">Your Current Job: ${user.job == null? "Unemployed" :user.job.title.concat(" in ").concat(user.job.game.name)}</h3>
							<c:if test="${user.job != null}">
						<form:form action="/jobs/quit2/${user.job.id}">
							<button type="submit">Quit</button>
						</form:form>
							</c:if>
					</div>
	            </div>
				<h1>Available Jobs at ${game.name}</h1>
				<div class="sortRow"></div>
	            <div class="jobListGrid">
	            	<p class="th">Job</p>
	            	<p class="th">Game</p>
	            	<p class="th">Description</p>
	            	<p class="th">Rupees</p>
	            	<p class="th">Morality</p>
	            	<p class="th">Apply</p>
						<c:forEach var="job" items="${jobs}">
						<c:if test="${job.characters.size() == 0 }">
					<p class="mdCol">${job.title}</p>
					<p class="mdCol"><a href="/game/${ job.game.id }">${job.game.name}</a></p>
					<p class="lgCol">${job.description}</p>
					<p class="smCol">${job.salary}</p>
						<c:if test="${job.morality==true }">
					<p class="smCol">Good</p>
						</c:if>
						<c:if test="${job.morality==false }">
					<p class="smCol">Bad</p>
						</c:if>
					
					<!-- apply button  -->
					<form:form class="smCol" action="/applyTwo/${job.id}"><button ${userJob.id != null ? "disabled style='background-color:lightgray'" : null} type="submit">Apply!</button></form:form>
						</c:if>
						</c:forEach>
	            </div>
<div class="employees">
			<h1>Employees</h1>
			<div class="connectionsGrid main">
			<c:forEach items="${ employees }" var="result">


				<div class="row">
					<img src="${ result.picture }" alt="" />
					<div class="resultInfo">
						<p><a href="/dashboard/${ result.id }">${ result.name } </a>(${ result.universe })</p>
						<p>${ result.job != null ? result.job.title.concat(" -- ").concat(result.game.name) : "Seeking Work"}</p>
					</div>
							<c:if test="${ result != user }">
							<c:choose>
							<c:when test="${ user.friends.contains(result) }">
						<a class="status">Already Connected</a>
							</c:when>
							<c:when test="${ user.friendRequests.contains(result) }">
						<a class="status">Pending Connection</a>
							</c:when>
							<c:when test="${ !result.friendRequests.contains(user) && !friends.contains(result) }">
						<a class="status" href="/requestConnection4/${ result.id }">Request Connection</a>
							</c:when>
							<c:otherwise>
						<a class="status">Pending Connection</a>
							</c:otherwise>
							</c:choose>
							</c:if>
				</div>

			</c:forEach>
			</div>
</div>
<%-- 				<table>
					<thead>
						<tr>
							<th class="mdCol">Title</th>
							<th class="lgCol">Description</th>
							<th class="smCol">Rupees</th>
							<th class="smCol">Morality</th>
							<th class="smCol">Apply</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="job" items = "${game.getJobs()}">
							<c:if test="${job.characters.size() == 0 }">
						<tr>
							<td class="mdCol">${job.title}</td> 
							<td class="lgCol">${job.description}</td>
							<td class="smCol">${job.salary}</td>
							<td class="smCol"><c:if test="${job.morality==true }">
								<p>Good</p>
								</c:if>
								<c:if test="${job.morality==false }">
								<p>Bad</p>
								</c:if>
							</td>
							<td class="smCol">
								<form:form action="/applyTwo/${job.game.id}"><button ${user.job.id != null ? "disabled style='background-color:lightgray'" : null} type="submit">Apply!</button></form:form>
						</tr>
					</c:if>	
					</c:forEach>
					</tbody>
				</table> --%>
			</div>
		</div>
	</div>
</body>

</html>