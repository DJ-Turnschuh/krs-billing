ESX = exports["es_extended"]:getSharedObject()


local PlayerData = {}

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)



-- Funzione Chiudi Fattura
RegisterNUICallback('chiudi', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Funzione Apri Fattura
function apriBilling()
    SendNUIMessage({
        type = "apriBilling",

    })
    SetNuiFocus(true, true)
end

function effettuaPagamento()
    SendNUIMessage({
        type = "effettuaPagamento",

    })
    SetNuiFocus(true, true)
end

-- Funzione invia fattura
RegisterNUICallback('invia', function(data, cb)
    print(tonumber(data.id), tonumber(data.importo))

    TriggerServerEvent('inviare:fattura', tonumber(data.id), tonumber(data.importo))
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('paga', function(data, cb)
    TriggerServerEvent('effettuare:paga')
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('pagamento')
AddEventHandler('pagamento', function()
    effettuaPagamento()
    SetNuiFocus(true, true)
end)


-- Funzione annulla fattura
RegisterNUICallback('annulla', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Comando Fattura
RegisterCommand('fattura', function()
    apriBilling()
end)


-- Utilizzo Item
RegisterNetEvent('apriNui:billing')
AddEventHandler('apriNui:billing', function()
    apriBilling()
    SetNuiFocus(true, true)
    TriggerServerEvent('apriNui:billing')
end)
