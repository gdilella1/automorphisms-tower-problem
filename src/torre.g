LoadPackage("sonata");
LoadPackage("polycyclic");
LoadPackage("hap");
LoadPackage("smallgrp");

# Funzione ausiliaria per la verifica dell'isomorfismo estratta dalla relazione
IsIsom := function (G, AutG, idG, idAutG, iso)
    # Controlla se i gruppi hanno dimensioni diverse
    if Size (G) <> Size (AutG) then
        return false; # Se gli ordini sono diversi, non possono essere isomorfi
    fi;

    # Controlla se i gruppi hanno un ID memorizzato in SmallGroups
    if Size (G) <= 2000 and Size (G) <> 1024 and Size (AutG) <= 2000 and Size (AutG) <> 1024 then
        idG := IdGroup(G);
        idAutG := IdGroup(AutG);
        
        if idG <> fail and idAutG <> fail then
            # Se entrambi i gruppi hanno un ID, controlla se gli ID coincidono
            if idG = idAutG then
                return true; # I gruppi sono isomorfi
            else
                return false; # I gruppi non sono isomorfi
            fi; 
        fi;
    else
        # Se fuori range o senza ID, usa la funzione di SONATA
        iso := IsIsomorphicGroup(G, AutG);
        return iso;
    fi;
end;

# Funzione Principale invocabile da terminale
TorreAutomorfismi := function(G_input)
    local start, currentGroup, currentAutGroup, steps, elapsedTime, 
          totalMinutes, totalSeconds, totalMilliseconds, idG, idAutG, iso;

    start := Runtime(); # Avvia il timer
    steps := 0;
    idG := fail;
    idAutG := fail;
    iso := false;

    # --- PREPARAZIONE DEL GRUPPO DI INPUT ---
    currentGroup := G_input;
    if Size(currentGroup) <> 1 then
        if IsPolycyclicGroup(currentGroup) then 
            currentGroup := Image(IsomorphismPcGroup(currentGroup));
        fi;
        currentGroup := GroupWithGenerators(MinimalGeneratingSet(currentGroup)); 
    fi;

    # --- CALCOLO DEL PRIMO AUTOCENTER ---
    currentAutGroup := Image(NiceMonomorphism(AutomorphismGroup(currentGroup)));
    if Size(currentAutGroup) <> 1 then
        if IsPolycyclicGroup(currentAutGroup) then 
            currentAutGroup := Image(IsomorphismPcGroup(currentAutGroup));
        fi;
        currentAutGroup := GroupWithGenerators(MinimalGeneratingSet(currentAutGroup));
    fi;

    Print("Passo ", steps, ": Il gruppo corrente è ", StructureDescription(currentGroup), "\n");

    # --- CICLO DELLA TORRE ---
    while not IsIsom(currentGroup, currentAutGroup, idG, idAutG, iso) do
        steps := steps + 1;
        currentGroup := currentAutGroup;
        
        Print("Passo ", steps, ": Il gruppo corrente è ", StructureDescription(currentGroup), "\n");
        
        currentAutGroup := Image(NiceMonomorphism(AutomorphismGroup(currentGroup)));
        if Size(currentAutGroup) <> 1 then
            if IsPolycyclicGroup(currentAutGroup) then 
                currentAutGroup := Image(IsomorphismPcGroup(currentAutGroup));
            fi;
            currentAutGroup := GroupWithGenerators(MinimalGeneratingSet(currentAutGroup));
        fi;
    od; # <--- Corretto l'originale 'end;' che causava l'errore di parsing

    # --- OUTPUT FINALE ---
    Print("\nDopo ", steps, " passi, abbiamo raggiunto un gruppo G tale che G è isomorfo ad Aut(G).\n");
    Print("La struttura di questo gruppo è: ", StructureDescription(currentGroup), "\n");

    # Tempo totale impiegato
    elapsedTime := Runtime() - start;
    if elapsedTime < 1000 then
        Print("Tempo impiegato: ", elapsedTime, " millisecondi\n");
    elif elapsedTime < 60000 then
        Print("Tempo impiegato: ", QuoInt(elapsedTime, 1000), " secondi e ", elapsedTime mod 1000, " millisecondi\n");
    else
        totalMinutes := QuoInt(elapsedTime, 60000);
        totalSeconds := QuoInt(elapsedTime mod 60000, 1000);
        totalMilliseconds := elapsedTime mod 1000;
        Print("Tempo impiegato: ", totalMinutes, " minuti, ", totalSeconds, " secondi e ", totalMilliseconds, " millisecondi\n");
    fi;

    return currentGroup;
end;