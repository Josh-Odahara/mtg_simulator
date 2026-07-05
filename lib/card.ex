defmodule AttackCard do
  defstruct [:name, :damage, :type]
end

defmodule DefenseCard do
  defstruct [:name, :effect, :block]
end

defmodule MTGSimulator.Card do
  alias AttackCard
  alias DefenseCard

  def start_deck do
    [
      %AttackCard{name: "Fireball Cat", damage: 10},
      %AttackCard{name: "Flying Lotus", damage: 5, type: :flying},
      %AttackCard{name: "Udeon, the Wise", damage: 20},
      %AttackCard{name: "Dog Fight", damage: 20},
      %AttackCard{name: "Punch", damage: 5},
      %AttackCard{name: "Kick", damage: 5},
      %AttackCard{name: "Helicopter Kick", damage: 15},
      %AttackCard{name: "Kiss of Death", damage: 100},
      %AttackCard{name: "EggHat Hooshi", damage: 25},
      %AttackCard{name: "BBhemoth", damage: 45},
      %DefenseCard{name: "Block", block: 5},
      %DefenseCard{name: "Heal", effect: :heal},
      %DefenseCard{name: "Reverse", effect: :reverse},
      %DefenseCard{name: "Fight Back", block: 10},
      %DefenseCard{name: "Double it and pass it to the next", effect: :reverse_double},
      %DefenseCard{name: "Ignore", effect: :bypass},
      %DefenseCard{name: "Swerve", block: 20},
      %DefenseCard{name: "Fly", block: 15},
      %DefenseCard{name: "Dig", block: 15},
      %DefenseCard{name: "Death's Rejection", block: 100}
    ]
  end
end
