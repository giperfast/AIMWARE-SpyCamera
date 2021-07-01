--[[
    <meta name="author" content="giperfast">
    shit code prod.
]]--
Reference = gui.Reference("Visuals", "Local", "Camera");
CAMBind = gui.Keybox(Reference, "cam.bind", "Camera Bind", 0);

function handler(cmd)
    GetViewAngles = cmd:GetViewAngles();
    if CAMBind:GetValue() and CAMBind:GetValue() > 0 and input.IsButtonDown(CAMBind:GetValue()) then
        client.Command("r_drawviewmodel 0");
        cmd.buttons = 0;
        cmd:SetForwardMove(0);
        cmd:SetSideMove(0);
        cmd:SetUpMove(0);
        cmd:SetViewAngles(backupAngles);
        engine.SetViewAngles(GetViewAngles);
        backupAnglesEngine = backupAngles;
        toggle = true;
    else
        client.Command("r_drawviewmodel 1");
        if backupAngles ~= GetViewAngles then
            backupAngles = GetViewAngles;
        end
        if toggle then
            engine.SetViewAngles(backupAnglesEngine);
            toggle = false;
        end
    end
end

callbacks.Register("CreateMove", "handler", handler);
