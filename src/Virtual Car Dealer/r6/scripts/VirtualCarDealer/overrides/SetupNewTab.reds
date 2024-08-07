import CarDealer.System.PurchasableVehicleSystem

// Temp flag to show atelier tab content
// TODO Need a better way to inject, research why LoadWebPage does not work with custom internet
@if(!ModuleExists("CarDealer.Site"))
@addField(BrowserController)
private let showCarDealer: Bool;

@if(!ModuleExists("CarDealer.Site"))
@addMethod(BrowserController)
protected cb func OnShowCarDealerEvent(evt: ref<ShowCarDealerEvent>) -> Bool {
  this.showCarDealer = evt.show;
}

@if(!ModuleExists("CarDealer.Site"))
@wrapMethod(ComputerInkGameController)
private final func ShowMenuByName(elementName: String) -> Void {
  if Equals(elementName, "carDealer") {
    this.QueueEvent(ShowCarDealerEvent.Create(true));
    let internetData: SInternetData = this.GetOwner().GetDevicePS().GetInternetData();
    this.GetMainLayoutController().ShowInternet(internetData.startingPage);
    this.RequestMainMenuButtonWidgetsUpdate();
    if NotEquals(elementName, "mainMenu") {
      this.GetMainLayoutController().MarkManuButtonAsSelected(elementName);
    };

    return ;
  };

  this.QueueEvent(ShowCarDealerEvent.Create(false));
  wrappedMethod(elementName);
}

@if(!ModuleExists("CarDealer.Site"))
@wrapMethod(ComputerInkGameController)
private final func HideMenuByName(elementName: String) -> Void {
  if Equals(elementName, "carDealer") {
    this.GetMainLayoutController().HideInternet();
    return; 
  };

  wrappedMethod(elementName);
}

@if(!ModuleExists("CarDealer.Site"))
@wrapMethod(ComputerControllerPS)
public final func GetMenuButtonWidgets() -> array<SComputerMenuButtonWidgetPackage> {
  if !this.m_computerSetup.m_mailsMenu {
    return wrappedMethod();
  };

  let packages: array<SComputerMenuButtonWidgetPackage> = wrappedMethod();
  let package: SComputerMenuButtonWidgetPackage;

  let player: ref<PlayerPuppet> = this.GetLocalPlayerControlledGameObject() as PlayerPuppet;
  let isInDangerZone: Bool = PurchasableVehicleSystem.GetInstance(player.GetGame()).IsInDangerZone(player);

  if !isInDangerZone {
    if this.IsMenuEnabled(EComputerMenuType.INTERNET) && ArraySize(packages) > 0 {
      package.widgetName = "carDealer";
      package.displayName = "Car Dealer";
      package.ownerID = this.GetID();
      package.iconID = n"iconCarDealer";
      package.widgetTweakDBID = this.GetMenuButtonWidgetTweakDBID();
      package.isValid = true;
      SWidgetPackageBase.ResolveWidgetTweakDBData(package.widgetTweakDBID, package.libraryID, package.libraryPath);
      ArrayPush(packages, package);
    };
  };

  return packages;
}

// kudos to NexusGuy999 for tab widget hack ^^
@if(!ModuleExists("CarDealer.Site"))
@wrapMethod(ComputerMenuButtonController)
public func Initialize(gameController: ref<ComputerInkGameController>, widgetData: SComputerMenuButtonWidgetPackage) -> Void {
  wrappedMethod(gameController, widgetData);

  if Equals(widgetData.widgetName, "carDealer") {
    inkImageRef.SetTexturePart(this.m_iconWidget, n"thorton_logo");
    inkImageRef.SetAtlasResource(this.m_iconWidget, r"base\\gameplay\\gui\\widgets\\vehicle\\thorton_all\\thorton_inkatlas.inkatlas");
  };
}

@if(!ModuleExists("CarDealer.Site"))
@wrapMethod(BrowserController)
protected cb func OnPageSpawned(widget: ref<inkWidget>, userData: ref<IScriptable>) -> Bool {
  wrappedMethod(widget, userData);

  let currentController: ref<WebPage>;
  if this.showCarDealer {
    currentController = this.m_currentPage.GetController() as WebPage;
    inkTextRef.SetText(this.m_addressText, "NETdir://cyber.car");
    currentController.PopulateDealerView(this.m_gameController.GetPlayerControlledObject());
  };
}

public class ShowCarDealerEvent extends Event {
  let show: Bool;

  public static func Create(show: Bool) -> ref<ShowCarDealerEvent> {
    let self: ref<ShowCarDealerEvent> = new ShowCarDealerEvent();
    self.show = show;
    return self;
  }
}
