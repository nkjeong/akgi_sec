<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);
    if (request.getProtocol().equals("HTTP/1.1")){
        response.setHeader("Cache-Control", "no-cache");
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector"%>
<%@ page import = "akgi.item.*"%>
<%@ page import = "akgi.category.*"%>
<%@ page import = "akgi.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String userId = (String)session.getAttribute("userId");
%>
<jsp:useBean id="getList" class="akgi.Main" scope="page"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>대광악기사</title>
        <script src="https://kit.fontawesome.com/99f7b4874c.js" crossorigin="anonymous"></script>
        <script defer src="/script/script.js"></script>
        <script defer src="/script/detailView.js"></script>
        <script defer src="/script/mainMenu.js"></script>
        <link href="/style/main.css" rel="stylesheet">
        <link href="/style/modal.css" rel="stylesheet">
        <link href="/style/detailView.css" rel="stylesheet">
        <link href="/style/mainMenu.css" rel="stylesheet">
        
    </head>
    <body>
        <section class="modalBack">
        </section>

        <header class="top">
            <div class="home">GRANSEN</div>
        </header>
        <section class="memberWrapper">
            <section class="member">
                <section class="memberLeft">
                    전문가용 악기 전문 브랜드 <span class="logoDecration">GRANSEN</span>
                </section>
                <section class="memberRight">
                    <%
                        if(userId == null){
                    %>
                            <section class="join" title="회원가입"><i class="fa-sharp fa-solid fa-person-circle-plus"></i></section>
                            <section class="login" title="로그인"><i class="fa-sharp fa-solid fa-right-to-bracket"></i></section>
                    <%
                        }else{
                    %>
                            <section>안녕하세요~ <%=userId%>님</section>
                            <section class="info" title="나의정보"><i class="fa-sharp fa-solid fa-user"></i></section>
                            <section class="logout" title="로그아웃"><i class="fa-sharp fa-solid fa-right-from-bracket"></i></section>
                    <%
                        }
                    %>
                    
                </section>
            </section>
        </section>
        <section class="categoryWrapper">
            <section class="category">
                <%
                    Vector<CategoryBeans> getCategoryList = getList.getCategoryList();
                    for(int i = 0 ; i < getCategoryList.size() ; i++){
                        CategoryBeans cb = (CategoryBeans)getCategoryList.elementAt(i);
                %>
                        <section title="<%=cb.getNameEng()%>" class="mainMenu" data-code="<%=cb.getCode()%>">
                            <%=cb.getName()%>
                            <section class="subMenu">ggggggggg</section>
                        </section>
                <%
                    }
                %>
            </section>
        </section>
        <section class="main">
            <section class="itemLabelWrapper">
                <section class="itemLabel">
                    <div>- BEST ITEM -</div>
                </section>
            </section>
            <section class="goodsWrapper bestItem">
                <section class="goodsLine">
                    <%
                        String price = "";
                        if(userId != null){
                            price = "price";
                        }else{
                            price = "nonprice";
                        }
                        Vector<ItemBeans> bestItemList = getList.getList("", "best");
                        for(int i = 0 ; i < bestItemList.size() ; i++){
                            ItemBeans bib = (ItemBeans)bestItemList.elementAt(i);
                            String getItemName = bib.getName();
                            String getItemCode = bib.getCode();
                    %>
                            <section class="goodsItem" data-code="<%=getItemCode%>" data-name="<%=getItemName%>">
                                <%
                                    int getItemNameLength = getItemName.length();
                                    if(getItemNameLength > 12){
                                        getItemName = getItemName.substring(0, 12)+"...";
                                    }
                                %>
                                <div title="<%=bib.getName()%>"><img src="/images/1000/gransen_<%=bib.getCode()%>.jpg"></div>
                                <div class="itemName"><%=getItemName%></div>
                                <div class="<%=price%>">
                                    <%
                                        int hiPrice = Integer.parseInt(bib.getPrice());

                                        if(hiPrice > 3000000){
                                    %>
                                            <%="<span style=\"font-weight:700;color:#e42221;\">상담 후 결정</span>"%>
                                    <%
                                        }else{
                                    %>
                                            <fmt:formatNumber value='<%=bib.getPrice()%>' groupingUsed='true'/> <span class="won">원</span>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    if(userId != null){
                                %>
                                        <div class="servicePricePrice">
                                            <fmt:formatNumber value='<%=bib.getServicePrice()%>' groupingUsed='true'/> <span class="won">원</span>
                                        </div>
                                <%
                                    }
                                %>
                            </section>
                    <%
                        }
                    %>
                </section>
            </section>
            <section class="bannerWrapper">
                <section class="banner_1">
                    <img src="/images_source/banner_1.png">
                </section>
            </section>
            <section class="searchWrapper">
                <section class="search">
                    <form class="searchForm" name="searchForm">
                        <section class="inputWrapper">
                            <section class="inputKeyWord">
                                <input type="text" class="keyWord" name="keyWord" placeholder="검색어를 입력하세요.">
                            </section>
                            <section class="inputButton">
                                <input type="button" value="SEARCH">
                            </section>
                        </section>
                    </form>
                </section>
            </section>
            <section class="itemLabelWrapper">
                <section class="itemLabel">
                    <div>- LIST -</div>
                </section>
            </section>
            <section class="goodsListWrapper">
                <%
                    Vector<ItemBeans> itemList = getList.getList("", "");
                    int total = itemList.size();
                    int rowItem = 5;
                    int row = (int)Math.ceil ((double)total/rowItem);
                    for(int i = 0 ; i < row ; i++){
                %>
                        <section class="goodsLine">
                            <%
                                for(int j = i*rowItem ; j < (i+1)*rowItem ; j++){
                                    if(j == total)break;
                                    ItemBeans ib = (ItemBeans)itemList.elementAt(j);
                                    String getItemName = ib.getName();
                                    String getItemCode = ib.getCode();
                            %>
                                    <section class="goodsItem" data-code="<%=getItemCode%>" data-name="<%=getItemName%>">
                                        <%
                                            int getItemNameLength = getItemName.length();
                                            if(getItemNameLength > 12){
                                                getItemName = getItemName.substring(0, 12)+"...";
                                            }
                                        %>
                                        <div title="<%=ib.getName()%>"><img src="/images/1000/gransen_<%=ib.getCode()%>.jpg"></div>
                                        <div class="itemName"><%=getItemName%></div>
                                        <div class="<%=price%>">
                                            <%
                                                int hiPrice = Integer.parseInt(ib.getPrice());

                                                if(hiPrice > 3000000){
                                            %>
                                                    <%="<span style=\"font-weight:700;color:#e42221;\">상담 후 결정</span>"%>
                                            <%
                                                }else{
                                            %>
                                                    <fmt:formatNumber value='<%=ib.getPrice()%>' groupingUsed='true'/> <span class="won">원</span>
                                            <%
                                                }
                                            %>
                                            
                                        </div>
                                        <%
                                            if(userId != null){
                                        %>
                                                <div class="servicePricePrice">
                                                    <fmt:formatNumber value='<%=ib.getServicePrice()%>' groupingUsed='true'/> <span class="won">원</span>
                                                </div>
                                        <%
                                            }  
                                        %>
                                    </section>
                            <%
                                }
                            %>
                        </section>
                <%
                    }
                %>
            </section>
            <section class="bannerWrapper">
                <section class="banner_2">
                    <img src="/images_source/banner_2.png">
                </section>
            </section>
            <section class="imgBannetWrapper">
                <section class="imgBanner">
                    <section class="banner">
                        <img src="/images_source/banner_3.png">
                    </section>
                    <section class="banner">
                        <img src="/images_source/banner_4.png">
                    </section>
                    <section class="banner">
                        <img src="/images_source/banner_5.png">
                    </section>
                </section>
            </section>
        </section>

        <section class="footer">
            <article>
                대표 : 김영채<br>
                사업자 등록번호 : 207-02-52461<br>
                통신판매업신고번호 : 2006-서울광진-2382<br>
                개인정보관리자 : 김진수<br>
                E-mail : <a href="mailto:kyc100k@naver.com" class="mail">kyc100k@naver.com</a>
            </article>
            <article>
                사업장 소재지 : 서울 광진구 광나루로56길 85, 4층 C111,112<br>
                출고 소재지 : 서울특별시 광진구 자양로 53-1<br>
                Tel : <a href="tel:02-456-2383" class="tel">02-456-2383</a>, Fax : 02-458-5776<br>
                COPYRIGHT <a href="mailto:kyc100k@naver.com" class="mail">akgi.co.kr</a> ALL RIGHTS RESERVER
            </article>
        </section>
    </body>
</html>