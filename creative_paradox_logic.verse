using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }


creative_paradox_logic := class(creative_device):

    @editable
    EndGameDevice : end_game_device = end_game_device{}

    @editable
    var WeaponGranters : []item_granter_device = array{}

    @editable
    var PlayerSpawners : []player_spawner_device = array{}

    @editable
    var Sentries : []sentry_device = array{}


    OnBegin<override>()<suspends> : void =

        for (Sentry : Sentries):
            Sentry.EliminatedEvent.Subscribe(TestPlayerEliminated) # Subscribe to each Sentry


 
    # Allows testing of GiveNextWeapon by spoofing Sentries as Players

    TestPlayerEliminated(Agent: ?agent) : void =
        Print("Sentry Down!")
        if(TeamPlayer := Agent?):
            GiveNextWeapon(TeamPlayer)

  
    EndGame(InPlayer : agent) : void =
        Print("Player reached final Tier, activating EndGameDevice")
        EndGameDevice.Activate(InPlayer)
