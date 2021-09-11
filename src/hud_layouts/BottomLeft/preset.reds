// -- Bottom Left

@addField(inkGameController)
public let CustomBottomLeftMinimap: ref<inkVerticalPanel>;

@addField(inkGameController)
public let CustomBottomLeftWanted: ref<inkVerticalPanel>;

@addField(inkGameController)
public let CustomBottomRight: ref<inkVerticalPanel>;

@addMethod(inkGameController)
public func CreateCustomSlots() -> Void {
  this.CustomBottomLeftMinimap = this.MakeVerticalSlot(
    n"CustomBottomLeftMinimap",
    new inkMargin(25.0, 0.0, 10.0, 25.0),
    inkEHorizontalAlign.Left,
    inkEVerticalAlign.Bottom,
    inkEAnchor.BottomLeft,
    new Vector2(0.0, 1.0),
    new Vector2(0.0, 1.0)
  );
  this.CustomBottomLeftMinimap.Reparent(this.RootSlot);

  this.CustomBottomLeftWanted = this.MakeVerticalSlot(
    n"CustomBottomLeftWanted",
    new inkMargin(20.0, 0.0, 20.0, 20.0),
    inkEHorizontalAlign.Left,
    inkEVerticalAlign.Bottom,
    inkEAnchor.BottomLeft,
    new Vector2(1.5, -0.4),
    new Vector2(1.5, -0.4)
  );
  this.CustomBottomLeftWanted.SetRotation(180.0);
  this.CustomBottomLeftWanted.Reparent(this.RootSlot);

  this.CustomBottomRight = this.MakeVerticalSlot(
    n"CustomBottomRight",
    new inkMargin(25.0, 0.0, 10.0, 25.0),
    inkEHorizontalAlign.Right,
    inkEVerticalAlign.Bottom,
    inkEAnchor.BottomRight,
    new Vector2(1.0, 1.0),
    new Vector2(1.0, 1.0)
  );
  this.CustomBottomRight.Reparent(this.RootSlot);
}

@addMethod(inkGameController)
public func AdjustWidgetsPositions() -> Void {
  this.minimapRef.Reparent(this.CustomBottomLeftMinimap);
  this.dpadHintRef.SetMargin(new inkMargin(0.0, 0.0, -20.0, 0.0));
  this.dpadHintRef.Reparent(this.BottomCenterSlot);
  this.inputHintRef.SetMargin(new inkMargin(0.0, 0.0, 30.0, 180.0));
  this.inputHintRef.Reparent(this.CustomBottomRight);
  this.itemsNotificationsRef.SetMargin(new inkMargin(0.0, -100.0, 0.0, 0.0));

  this.SetWidgetParams(
    this.wantedBarRef, 
    new inkMargin(0.0, 0.0, 0.0, 0.0), 
    inkEHorizontalAlign.Center, 
    inkEVerticalAlign.Top, 
    inkEAnchor.Centered, 
    new Vector2(1.5, -0.4),
    new Vector2(1.5, -0.4)
  );
  this.wantedBarRef.Reparent(this.CustomBottomLeftWanted);

  this.SetWidgetParams(
    this.carHudRef, 
    new inkMargin(0.0, 0.0, 0.0, 0.0), 
    inkEHorizontalAlign.Right, 
    inkEVerticalAlign.Bottom, 
    inkEAnchor.BottomRight, 
    new Vector2(1.0, 1.0),
    new Vector2(1.0, 1.0)
  );
  this.carHudRef.SetTranslation(new Vector2(-40.0, 0.0));

  this.SetWidgetParams(
    this.BottomRightHorizontalSlot, 
    new inkMargin(0.0, 0.0, 20.0, 10.0), 
    inkEHorizontalAlign.Right, 
    inkEVerticalAlign.Bottom, 
    inkEAnchor.BottomRight, 
    new Vector2(0.0, 1.0),
    new Vector2(0.0, 1.0)
  );
  this.BottomRightHorizontalSlot.Reparent(this.CustomBottomRight);

  this.SetWidgetParams(
    this.vehicleSummonNotificationRef, 
    new inkMargin(0.0, 0.0, 40.0, 0.0), 
    inkEHorizontalAlign.Right, 
    inkEVerticalAlign.Center, 
    inkEAnchor.CenterRight, 
    new Vector2(1.0, 1.0),
    new Vector2(1.0, 1.0)
  );
  this.vehicleSummonNotificationRef.Reparent(this.RootSlot);
}

// Move compass and current time widgets to bottom of the minimap
@wrapMethod(MinimapContainerController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();
  let root: ref<inkCompoundWidget> = this.GetRootCompoundWidget();
  let compass: ref<inkWidget> = root.GetWidget(n"MiniMapContainer/compassContainer");
  let timeText: ref<inkWidget> = root.GetWidget(n"location/unredMessagesGroup");
  let timeTranslation: Float = root.GetWidth() - timeText.GetWidth() - 40.0;
  let compassMarginLeft: Float = compass.GetWidth() / 2.5;
  let compassMarginTop: Float = compass.GetWidth() / 5;
  root.GetWidget(n"holder").SetVisible(false);
  compass.SetMargin(new inkMargin(-compassMarginLeft, -compassMarginTop, 0.0, 0.0));
  compass.SetHAlign(inkEHorizontalAlign.Left);
  compass.SetVAlign(inkEVerticalAlign.Bottom);
  compass.SetAnchor(inkEAnchor.BottomLeft);
  timeText.SetTranslation(new Vector2(timeTranslation, 0.0));
}

// Remove crime reported label from wanted bar widget
@wrapMethod(WantedBarGameController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();
  let root: ref<inkCompoundWidget> = this.GetRootCompoundWidget();
  root.GetWidget(n"wanted_levels/attention").SetVisible(false);
}