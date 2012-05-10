var NAVTREE =
[
  [ "iFUSD", "index.html", [
    [ "Class List", "annotated.html", [
      [ "AboutViewController", "interface_about_view_controller.html", null ],
      [ "BudgetViewController", "interface_budget_view_controller.html", null ],
      [ "CalViewController", "interface_cal_view_controller.html", null ],
      [ "ComViewController", "interface_com_view_controller.html", null ],
      [ "DistrictViewController", "interface_district_view_controller.html", null ],
      [ "EmergencyViewController", "interface_emergency_view_controller.html", null ],
      [ "errorViewController", "interfaceerror_view_controller.html", null ],
      [ "fusdAppDelegate", "interfacefusd_app_delegate.html", null ],
      [ "HomeViewController", "interface_home_view_controller.html", null ],
      [ "iRate", "interfacei_rate.html", null ],
      [ "iRate()", "interfacei_rate_07_08.html", null ],
      [ "<iRateDelegate>", "protocoli_rate_delegate-p.html", null ],
      [ "NewsViewController", "interface_news_view_controller.html", null ],
      [ "PushSchoolsViewController", "interface_push_schools_view_controller.html", null ],
      [ "Reachability", "interface_reachability.html", null ],
      [ "SBoardViewController", "interface_s_board_view_controller.html", null ],
      [ "SchoolsViewController", "interface_schools_view_controller.html", null ],
      [ "SettingViewController", "interface_setting_view_controller.html", null ],
      [ "UINavigationBar", "class_u_i_navigation_bar.html", null ],
      [ "UserGuideViewController", "interface_user_guide_view_controller.html", null ]
    ] ],
    [ "Class Index", "classes.html", null ],
    [ "Class Members", "functions.html", null ],
    [ "File List", "files.html", [
      [ "fusd/AboutViewController.h", "_about_view_controller_8h.html", null ],
      [ "fusd/AboutViewController.m", "_about_view_controller_8m.html", null ],
      [ "fusd/BudgetViewController.h", "_budget_view_controller_8h.html", null ],
      [ "fusd/BudgetViewController.m", "_budget_view_controller_8m.html", null ],
      [ "fusd/CalViewController.h", "_cal_view_controller_8h.html", null ],
      [ "fusd/CalViewController.m", "_cal_view_controller_8m.html", null ],
      [ "fusd/ComViewController.h", "_com_view_controller_8h.html", null ],
      [ "fusd/ComViewController.m", "_com_view_controller_8m.html", null ],
      [ "fusd/DistrictViewController.h", "_district_view_controller_8h.html", null ],
      [ "fusd/DistrictViewController.m", "_district_view_controller_8m.html", null ],
      [ "fusd/EmergencyViewController.h", "_emergency_view_controller_8h.html", null ],
      [ "fusd/EmergencyViewController.m", "_emergency_view_controller_8m.html", null ],
      [ "fusd/errorViewController.h", "error_view_controller_8h.html", null ],
      [ "fusd/errorViewController.m", "error_view_controller_8m.html", null ],
      [ "fusd/fusdAppDelegate.h", "fusd_app_delegate_8h.html", null ],
      [ "fusd/fusdAppDelegate.m", "fusd_app_delegate_8m.html", null ],
      [ "fusd/HomeViewController.h", "_home_view_controller_8h.html", null ],
      [ "fusd/HomeViewController.m", "_home_view_controller_8m.html", null ],
      [ "fusd/iRate.h", "i_rate_8h.html", null ],
      [ "fusd/iRate.m", "i_rate_8m.html", null ],
      [ "fusd/main.m", "main_8m.html", null ],
      [ "fusd/NewsViewController.h", "_news_view_controller_8h.html", null ],
      [ "fusd/NewsViewController.m", "_news_view_controller_8m.html", null ],
      [ "fusd/PushSchoolsViewController.h", "_push_schools_view_controller_8h.html", null ],
      [ "fusd/PushSchoolsViewController.m", "_push_schools_view_controller_8m.html", null ],
      [ "fusd/Reachability.h", "_reachability_8h.html", null ],
      [ "fusd/Reachability.m", "_reachability_8m.html", null ],
      [ "fusd/SBoardViewController.h", "_s_board_view_controller_8h.html", null ],
      [ "fusd/SBoardViewController.m", "_s_board_view_controller_8m.html", null ],
      [ "fusd/SchoolsViewController.h", "_schools_view_controller_8h.html", null ],
      [ "fusd/SchoolsViewController.m", "_schools_view_controller_8m.html", null ],
      [ "fusd/SettingViewController.h", "_setting_view_controller_8h.html", null ],
      [ "fusd/SettingViewController.m", "_setting_view_controller_8m.html", null ],
      [ "fusd/UserGuideViewController.h", "_user_guide_view_controller_8h.html", null ],
      [ "fusd/UserGuideViewController.m", "_user_guide_view_controller_8m.html", null ]
    ] ],
    [ "File Members", "globals.html", null ]
  ] ]
];

function createIndent(o,domNode,node,level)
{
  if (node.parentNode && node.parentNode.parentNode)
  {
    createIndent(o,domNode,node.parentNode,level+1);
  }
  var imgNode = document.createElement("img");
  if (level==0 && node.childrenData)
  {
    node.plus_img = imgNode;
    node.expandToggle = document.createElement("a");
    node.expandToggle.href = "javascript:void(0)";
    node.expandToggle.onclick = function() 
    {
      if (node.expanded) 
      {
        $(node.getChildrenUL()).slideUp("fast");
        if (node.isLast)
        {
          node.plus_img.src = node.relpath+"ftv2plastnode.png";
        }
        else
        {
          node.plus_img.src = node.relpath+"ftv2pnode.png";
        }
        node.expanded = false;
      } 
      else 
      {
        expandNode(o, node, false);
      }
    }
    node.expandToggle.appendChild(imgNode);
    domNode.appendChild(node.expandToggle);
  }
  else
  {
    domNode.appendChild(imgNode);
  }
  if (level==0)
  {
    if (node.isLast)
    {
      if (node.childrenData)
      {
        imgNode.src = node.relpath+"ftv2plastnode.png";
      }
      else
      {
        imgNode.src = node.relpath+"ftv2lastnode.png";
        domNode.appendChild(imgNode);
      }
    }
    else
    {
      if (node.childrenData)
      {
        imgNode.src = node.relpath+"ftv2pnode.png";
      }
      else
      {
        imgNode.src = node.relpath+"ftv2node.png";
        domNode.appendChild(imgNode);
      }
    }
  }
  else
  {
    if (node.isLast)
    {
      imgNode.src = node.relpath+"ftv2blank.png";
    }
    else
    {
      imgNode.src = node.relpath+"ftv2vertline.png";
    }
  }
  imgNode.border = "0";
}

function newNode(o, po, text, link, childrenData, lastNode)
{
  var node = new Object();
  node.children = Array();
  node.childrenData = childrenData;
  node.depth = po.depth + 1;
  node.relpath = po.relpath;
  node.isLast = lastNode;

  node.li = document.createElement("li");
  po.getChildrenUL().appendChild(node.li);
  node.parentNode = po;

  node.itemDiv = document.createElement("div");
  node.itemDiv.className = "item";

  node.labelSpan = document.createElement("span");
  node.labelSpan.className = "label";

  createIndent(o,node.itemDiv,node,0);
  node.itemDiv.appendChild(node.labelSpan);
  node.li.appendChild(node.itemDiv);

  var a = document.createElement("a");
  node.labelSpan.appendChild(a);
  node.label = document.createTextNode(text);
  a.appendChild(node.label);
  if (link) 
  {
    a.href = node.relpath+link;
  } 
  else 
  {
    if (childrenData != null) 
    {
      a.className = "nolink";
      a.href = "javascript:void(0)";
      a.onclick = node.expandToggle.onclick;
      node.expanded = false;
    }
  }

  node.childrenUL = null;
  node.getChildrenUL = function() 
  {
    if (!node.childrenUL) 
    {
      node.childrenUL = document.createElement("ul");
      node.childrenUL.className = "children_ul";
      node.childrenUL.style.display = "none";
      node.li.appendChild(node.childrenUL);
    }
    return node.childrenUL;
  };

  return node;
}

function showRoot()
{
  var headerHeight = $("#top").height();
  var footerHeight = $("#nav-path").height();
  var windowHeight = $(window).height() - headerHeight - footerHeight;
  navtree.scrollTo('#selected',0,{offset:-windowHeight/2});
}

function expandNode(o, node, imm)
{
  if (node.childrenData && !node.expanded) 
  {
    if (!node.childrenVisited) 
    {
      getNode(o, node);
    }
    if (imm)
    {
      $(node.getChildrenUL()).show();
    } 
    else 
    {
      $(node.getChildrenUL()).slideDown("fast",showRoot);
    }
    if (node.isLast)
    {
      node.plus_img.src = node.relpath+"ftv2mlastnode.png";
    }
    else
    {
      node.plus_img.src = node.relpath+"ftv2mnode.png";
    }
    node.expanded = true;
  }
}

function getNode(o, po)
{
  po.childrenVisited = true;
  var l = po.childrenData.length-1;
  for (var i in po.childrenData) 
  {
    var nodeData = po.childrenData[i];
    po.children[i] = newNode(o, po, nodeData[0], nodeData[1], nodeData[2],
        i==l);
  }
}

function findNavTreePage(url, data)
{
  var nodes = data;
  var result = null;
  for (var i in nodes) 
  {
    var d = nodes[i];
    if (d[1] == url) 
    {
      return new Array(i);
    }
    else if (d[2] != null) // array of children
    {
      result = findNavTreePage(url, d[2]);
      if (result != null) 
      {
        return (new Array(i).concat(result));
      }
    }
  }
  return null;
}

function initNavTree(toroot,relpath)
{
  var o = new Object();
  o.toroot = toroot;
  o.node = new Object();
  o.node.li = document.getElementById("nav-tree-contents");
  o.node.childrenData = NAVTREE;
  o.node.children = new Array();
  o.node.childrenUL = document.createElement("ul");
  o.node.getChildrenUL = function() { return o.node.childrenUL; };
  o.node.li.appendChild(o.node.childrenUL);
  o.node.depth = 0;
  o.node.relpath = relpath;

  getNode(o, o.node);

  o.breadcrumbs = findNavTreePage(toroot, NAVTREE);
  if (o.breadcrumbs == null)
  {
    o.breadcrumbs = findNavTreePage("index.html",NAVTREE);
  }
  if (o.breadcrumbs != null && o.breadcrumbs.length>0)
  {
    var p = o.node;
    for (var i in o.breadcrumbs) 
    {
      var j = o.breadcrumbs[i];
      p = p.children[j];
      expandNode(o,p,true);
    }
    p.itemDiv.className = p.itemDiv.className + " selected";
    p.itemDiv.id = "selected";
    $(window).load(showRoot);
  }
}

