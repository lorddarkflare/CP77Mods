module EnhancedCraft.Common

// -- Checks if item with id has iconic flag defined in TweakXL
public static func IsPresetIconic(id: TweakDBID) -> Bool {
  let variant: Variant = TweakDBInterface.GetFlat(id + t".iconicVariant");
  let isIconic: Bool = FromVariant<Bool>(variant);
  return isIconic;
}

// -- Checks if item has DLC jackets variations
public static func HasDLCItems(id: TweakDBID) -> Bool {
  let variant: Variant = TweakDBInterface.GetFlat(id + t".hasDLCItems");
  let hasItems: Bool = FromVariant<Bool>(variant);
  return hasItems;
}

// -- Get quality representation as int value to bind with the one defined in IconicRecipeCondition
public static func GetBaseQualityValue(quality: CName) -> Int32  {
  switch (quality) {
    case n"Rare": return 1;
    case n"Epic": return 2;
    case n"Legendary": return 3;
  };

  return 0;
}

// -- Basic logging function
public static func L(str: String) -> Void {
  // LogChannel(n"DEBUG", s"Craft: \(str)");
}

// -- ArchiveXL checker
@addField(SingleplayerMenuGameController)
public let archiveXlChecked: Bool;

@wrapMethod(SingleplayerMenuGameController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();

  let warning: ref<inkText>;
  let str: String = GetLocalizedTextByKey(n"Mod-Craft-Settings-Base");
  if Equals(str, "Mod-Craft-Settings-Base") || Equals(str, "") {
    if !this.archiveXlChecked {
      this.archiveXlChecked = true;
      warning = new inkText();
      warning.SetName(n"CustomWarning");
      warning.SetText("Archive XL not detected! Make sure that it was installed correctly.");
      warning.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
      warning.SetFontSize(64);
      warning.SetHAlign(inkEHorizontalAlign.Fill);
      warning.SetVAlign(inkEVerticalAlign.Bottom);
      warning.SetAnchor(inkEAnchor.BottomFillHorizontaly);
      warning.SetAnchorPoint(0.5, 1.0);
      warning.SetLetterCase(textLetterCase.OriginalCase);
      warning.SetMargin(new inkMargin(20.0, 0.0, 0.0, 10.0));
      warning.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      warning.BindProperty(n"tintColor", n"MainColors.Red");
      warning.Reparent(this.GetRootCompoundWidget());
    };
  };
}
