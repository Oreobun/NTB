class Route{
  var route;
  var start;
  var end;
  Route(var start, var end){
    this.start = start;
    this.end = end;
  }
  void getRoute(){
    return route;
  }
  void setRoute(String route){
    this.route = route;
  }
}