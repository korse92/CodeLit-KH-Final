<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title" />
</jsp:include>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



  <script>window.jQuery || document.write(decodeURIComponent('%3Cscript src="js/jquery.min.js"%3E%3C/script%3E'))</script>
      <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/21.1.3/css/dx.common.css" />
      <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/21.1.3/css/dx.light.css" />
      <script src="https://cdn3.devexpress.com/jslib/21.1.3/js/dx.all.js"></script>

<!-- 컨텐츠 시작 -->

        <style>
            #chart {
                height: 30rem;
                width: 50rem;
            }

            h3 {
                padding-top:3rem;
            }

            #nav-tabContent {
                padding-top: 0.1rem;
                padding-bottom: 10rem;
            }

            /**********************/

            #sideChart {
                height: 30rem;
                width: 50rem;
            }

            #searchDiv {
              width: 20rem;
              margin: auto;
            }

            /***********************/

            #pie {
                height: 30rem;
            }

            #pie * {
                margin: 0 auto;
            }

			/**********************/
			
			pivotgrid {
            	margin-top: 20px;
        	}
        </style>

        <script>

            $(function(){

                // standard bar
                $("#chart").dxChart({
                    dataSource: barSource, 
                    series: {
                        argumentField: "lecture",
                        valueField: "click",
                        name: "강의 이름",
                        type: "bar",
                        color: '#b8b5ff',
                        label: {
                        	visible: true
                        }
                    },
                    "export": {
                        enabled: true
                    }
                });



                // pie chart
                $("#pie").dxPieChart({
                    size: {
                        width: 600
                    },
                    palette: "bright",
                    dataSource: pieSource,
                    series: [
                        {
                            argumentField: "category",
                            valueField: "sales",
                            label: {
                                visible: true,
                                connector: {
                                    visible: false,
                                    width: 1
                                }
                            }
                        }
                    ],
                    title: "카테고리별 매출",
                    "export": {
                        enabled: true
                    },
                    onPointClick: function (e) {
                        var point = e.target;
                
                        toggleVisibility(point);
                    },
                    onLegendClick: function (e) {
                        var arg = e.target;
                
                        toggleVisibility(this.getAllSeries()[0].getPointsByArg(arg)[0]);
                    }
                });
                
                function toggleVisibility(item) {
                    if(item.isVisible()) {
                        item.hide();
                    } else { 
                        item.show();
                    }
                }
                
                
                
                // pivot-grid
                var pivotGridChart = $("#pivotgrid-chart").dxChart({
                    commonSeriesSettings: {
                        type: "bar"
                    },
                    tooltip: {
                        enabled: true,
                        customizeTooltip: function (args) {
                            var valueText = 
                            	(args.seriesName.indexOf("Total") != -1)
                            	? args.originalValue + "원"
                            	: args.originalValue + "개";
                
                            return {
                                html: args.seriesName + "<div>"
                                    + valueText + "</div>"
                            };
                        }
                    },
                    size: {
                        height: 320
                    },
                    adaptiveLayout: {
                        width: 450
                    }
                }).dxChart("instance");
                
                var pivotGrid = $("#pivotgrid").dxPivotGrid({
                    allowSortingBySummary: true,
                    allowFiltering: true,
                    showBorders: true,
                    showColumnGrandTotals: false,
                    showRowGrandTotals: false,
                    showRowTotals: false,
                    showColumnTotals: false,
                    fieldChooser: {
                        enabled: true
                    },
                    dataSource: {
                        fields: [{
                            caption: "category",
                            width: 120,
                            dataField: "category",
                            area: "row"
                        }, {
                        	caption: "lectureName",
                        	width: 200,
                        	dataField: "lectureName",
                        	area: "row"
                        }, {
                            caption: "Total",
                            dataField: "price",
                            dataType: "number",
                            summaryType: "sum",
                            format: {
                                formatter: function (originalValue) {
                                    return "&#8361; " + originalValue;
                                }
                            },
                            area: "data"
                        }, {
                            summaryType: "count",
                            area: "data"
                        }, {
                            dataField: "date",
                            dataType: "date",
                            area: "column"
                        }, {
                            groupName: "date",
                            groupInterval: "day"
                        }
                      ],
                        store: sales
                    }
                }).dxPivotGrid("instance");
                
                pivotGrid.bindChart(pivotGridChart, {
                    dataFieldsDisplayMode: "splitPanes",
                    alternateDataFields: false
                });

            }); // $()


            
            function search(e) {

                let searchKeyword = document.getElementById("searchKeyword").value;

				var flag = true;
                var data_ = null;
				
                $.ajax({
                	url: "${pageContext.request.contextPath}/admin/userClick.do",
                	method: "GET",
                	data: {
                		userName : searchKeyword
                	},
                	success: function(data) {
                		console.log("ajax 석세스");
                		if(data[0] == null) {
                			alert("아이디가 유효하지 않거나 검색결과가 없습니다.");
                			
                		} else {
                			
                            // side by side bar 변수
                            var sideSource = [{
                                state: data[0].lectureName,
                                user: data[0].clickNo,
                                avg: data[0].avg
                            }, {
                                state: data[1].lectureName,
                                user: data[1].clickNo,
                                avg: data[1].avg
                            }, {
                                state: data[2].lectureName,
                                user: data[2].clickNo,
                                avg: data[2].avg
                            }, {
                                state: data[3].lectureName,
                                user: data[3].clickNo,
                                avg: data[3].avg
                            }, {
                                state: data[4].lectureName,
                                user: data[4].clickNo,
                                avg: data[4].avg
                            }];
                			
	                        // side-bar chart
	                        $("#sideChart").dxChart({
	                            dataSource: sideSource,
	                            commonSeriesSettings: {
	                                argumentField: "state",
	                                type: "bar",
	                                hoverMode: "allArgumentPoints",
	                                selectionMode: "allArgumentPoints",
	                                label: {
	                                    visible: true,
	                                    format: {
	                                        type: "fixedPoint",
	                                        precision: 0
	                                    }
	                                }
	                            },
	                            series: [
	                                { valueField: "user", name: searchKeyword },
	                                { valueField: "avg", name: "평균" }
	                            ],
	                            title: "유저 클릭 상위 및 전체 평균 비교",
	                            legend: {
	                                verticalAlignment: "bottom",
	                                horizontalAlignment: "center"
	                            },
	                            "export": {
	                                enabled: true
	                            },
	                            onPointClick: function (e) {
	                                e.target.select();
	                            }
	                        });
                		}
                	},
                	error: function(xhr, status, err) {
                		console.log("ajax 오류");
                	},
                	complete: function() {
                		console.log("ajax 실행됨");
                	}
                		
                });

            } // search()




            // standard bar 변수
            var barSource = [{
                lecture: "${clickList[0].lectureName}",
                click: ${clickList[0].clickCount}
            }, {
                lecture: "${clickList[1].lectureName}",
                click: ${clickList[1].clickCount}
            }, {
                lecture: "${clickList[2].lectureName}",
                click: ${clickList[2].clickCount}
            }, {
                lecture: "${clickList[3].lectureName}",
                click: ${clickList[3].clickCount}
            }, {
                lecture: "${clickList[4].lectureName}",
                click: ${clickList[4].clickCount}
            }];



            // pie chart 변수
            var pieSource = [{
                category: "${categorySales[0].lecCatName}",
                sales: ${categorySales[0].sales}
            }, {
                category: "${categorySales[1].lecCatName}",
                sales: ${categorySales[1].sales}
            }, {
                category: "${categorySales[2].lecCatName}",
                sales: ${categorySales[2].sales}
            }];

            
           
            
                        
           // pivot grid 변수 (기간별 카테고리별 매출)
           var sales = [];
           
        </script>
        
        <c:forEach items="${categorySalesSummary}" var="css">
        	<script>
	        	var elem = {
	        			"lectureNo": "${css.lectureNo}",
	        			"lectureName": "${css.lectureName}",
	        			"category": "${css.lecCatName}",
	        			"date": "${css.payDate}",
	        			"price": ${css.price}
	        	};
	        	sales.push(elem);
        	</script>
        </c:forEach>
        
        
<!-- 개인 CSS, JS 위치 -->

	<div class="container">
	


        <h3>데이터 분석</h3>

        <nav class="my-5">
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-1-tab" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="nav-1" aria-selected="true">강의 통산 클릭수 상위</button>
                <button class="nav-link" id="nav-2-tab" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="nav-2" aria-selected="false">유저별 강의 클릭 수 상위</button>
                <button class="nav-link" id="nav-3-tab" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="nav-3" aria-selected="false">카테고리별 매출비중</button>
                <button class="nav-link" id="nav-4-tab" data-bs-toggle="tab" data-bs-target="#nav-4" type="button" role="tab" aria-controls="nav-4" aria-selected="false">기간별 카테고리별 매출</button>
            </div>
        </nav>
        <div class="tab-content" id="nav-tabContent">

            <div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-1-tab">
                <div class="demo-container">
                    <div id="chart" class="mx-auto mt-5"></div>
                </div>
            </div>

            <div class="tab-pane fade" id="nav-2" role="tabpanel" aria-labelledby="nav-2-tab">

              <div class="input-group" id="searchDiv">
                <input type="text" class="form-control mb-5" placeholder="유저 아이디" id="searchKeyword">
                <button class="btn btn-outline-secondary mb-5" type="button" id="inputGroupFileAddon04" onclick="search(event);">검색</button>
                <!-- <span class="input-group-text mb-5" onclick="search();">검색</span> -->
              </div>

              	<div class="demo-container">
                	<div id="sideChart" class="mx-auto mt-5"></div>
            	</div>
            </div>

            <div class="tab-pane fade" id="nav-3" role="tabpanel" aria-labelledby="nav-3-tab">
                <div class="demo-container">
                    <div id="pie" class="mx-auto mt-5"></div>
                </div>
            </div>

			<div class="tab-pane fade active" id="nav-4" role="tabpanel" aria-labelledby="nav-4-tab">
				<div class="demo-container">
				  <div id="pivotgrid-demo">
				      <div id="pivotgrid-chart" class="mx-auto"></div>
				      <div id="pivotgrid" class="mx-auto"></div>
				  </div>
				</div>
            </div>
        </div>










	
	</div>

<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>