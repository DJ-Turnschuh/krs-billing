ESX = exports["es_extended"]:getSharedObject()


local d
local i
local s
-- Funzione Invia Fattura
RegisterNetEvent('inviare:fattura', function(destinatario, importo)
    print(destinatario)
    local xPlayer = ESX.GetPlayerFromId(destinatario)
    local mittente = source

    local sContanti = xPlayer.getAccount("money").money
    print(importo)
    TriggerClientEvent('pagamento', xPlayer.source)
    -- Stampa i dettagli della fattura inviata nella console del server
    print('Fattura inviata:')
    print('  Mittente: ' .. GetPlayerName(mittente))
    print('  Destinatario: ' .. GetPlayerName(destinatario))
    print('  Importo: $' .. importo)

    TriggerClientEvent('esx:showNotification', mittente,
        'Hai inviato una fattura di $' .. importo .. ' a ' .. GetPlayerName(destinatario) .. '.')

    -- Stampa i dettagli della fattura ricevuta nella console del server
    print('Fattura ricevuta:')
    print('  Mittente: ' .. GetPlayerName(mittente))
    print('  Destinatario: ' .. GetPlayerName(destinatario))
    print('  Importo: $' .. importo)

    TriggerClientEvent('esx:showNotification', destinatario,
        'Hai ricevuto una fattura di $' .. importo .. ' da ' .. GetPlayerName(mittente) .. '.')

    i = importo
    d = destinatario
    s = mittente
end)



RegisterNetEvent('effettuare:paga', function()
    local destinatario = d
    local importo = i
    local source = s
    local xTarget = ESX.GetPlayerFromId(destinatario)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = xPlayer.getJob().name
    local sContanti = xTarget.getAccount("money").money
    print(xPlayer.source)
    print(xTarget.source)
    if sContanti >= importo then
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. society, function(account)
            account.addMoney(importo)
        end)
        xTarget.removeMoney(importo)
       -- xTarget.addAccountMoney(source, importo)
    else
        xTarget.showNotification("Non hai abbastanza soldi")
    end
end)


-- Funzione Usa Item Fattura
ESX.RegisterUsableItem("fattura", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    local krsBilling = xPlayer.getInventoryItem("fattura").count

    if krsBilling > 0 then
        xPlayer.removeInventoryItem('fattura', 1)
        TriggerClientEvent("apriNui:billing", xPlayer.source)
    else
        TriggerClientEvent('ox_lib:notify', xPlayer.source,
            { type = 'error', description = 'Non hai gli oggetti necessari per creare una fattura' })
    end
end)

RegisterNetEvent('apriNui:billing')
AddEventHandler('apriNui:billing', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('fattura', 1)
end)