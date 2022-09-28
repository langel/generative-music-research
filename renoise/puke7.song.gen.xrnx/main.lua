
local function euclid(line, slot, note, length, offset)
  if line % length == offset then
    slot.instrument_value = note.inst
    slot.note_value = note.pitch
    slot.volume_value = note.vol
  end
end

-- offset for whatever root tone value
local key_notes = { 
  0, 2, 3, 5, 7, 9, 11, 
  12, 14, 15, 17, 19, 21, 23,
  24, 26, 27, 29, 31, 33, 35,
  36, 38, 39, 41, 43, 45, 47,
}
local pattern_length = 64
local perc_notes = {
  kick = { inst = 1, pitch = 36, vol = 0xff },
  kick_soft = { inst = 1, pitch = 36, vol = 0x5f },
  hat_closed = { inst = 1, pitch = 42, vol = 0x77 },
  hat_closed_soft = { inst = 1, pitch = 42, vol = 0x67 },
  hat_open = { inst = 1, pitch = 46, vol = 0x6f },
  snare = { inst = 1, pitch = 38, vol = 0xff },
  snare_soft = { inst = 1, pitch = 38, vol = 0x5f },
}
local sequence_length = 28;
local s = renoise.song()
local base = 34
local root = 1
local pattern
local line
local i


local function part_a()  
    -- drums
    local slot = s:pattern(pattern):track(1):line(line):note_column(1)
    euclid(i, slot, perc_notes.kick_soft, 14, 1)
    euclid(i, slot, perc_notes.kick_soft, 24, 1)
    euclid(i, slot, perc_notes.kick_soft, 30, 1)
    euclid(i, slot, perc_notes.kick_soft, 56, 1)
    euclid(i, slot, perc_notes.kick, 16, 1)
    local slot = s:pattern(pattern):track(1):line(line):note_column(2)
    euclid(i, slot, perc_notes.snare_soft, 12, 7)
    euclid(i, slot, perc_notes.snare_soft, 18, 17)
    euclid(i, slot, perc_notes.snare_soft, 56, 29)
    euclid(i, slot, perc_notes.snare, 16, 9)
    local slot = s:pattern(pattern):track(1):line(line):note_column(3)
    euclid(i, slot, perc_notes.hat_closed_soft, 10, 8)
    euclid(i, slot, perc_notes.hat_closed, 2, 1)
    euclid(i, slot, perc_notes.hat_open, 12, 11)
    --OFF
    local note = { inst = 1 }
    note.pitch = 120
    note.vol = 0xff
    euclid(i, slot, note, 17, 0)
    euclid(i, slot, note, 11, 0)
    -- bass
    local slot = s:pattern(pattern):track(2):line(line):note_column(1)
    local note_val = root + i % 16
    local note = { inst = 2, pitch = key_notes[note_val] + base }
    note.vol = 0x5f
    euclid(i, slot, note, 2, 1)
    note.vol = 0x7f
    euclid(i, slot, note, 10, 8)
    euclid(i, slot, note, 16, 1)
    note.pitch = note.pitch + 12
    euclid(i, slot, note, 19, 2)
    --OFF
    note.pitch = 120
    note.vol = 0xff
    euclid(i, slot, note, 17, 0)
    euclid(i, slot, note, 11, 0)
    -- keys
    local note = { inst = 3, pitch = root, vol = 0x7f }
    local slot = s:pattern(pattern):track(3):line(line):note_column(1)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root] + base + math.floor(math.random() * 4) * 12 + 12
    euclid(i, slot, note, 32, 1)
    euclid(i, slot, note, 12, 7)
    euclid(i, slot, note, 14, 9)
    local slot = s:pattern(pattern):track(3):line(line):note_column(2)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root + 2] + base + math.floor(math.random() * 3) * 12 + 12
    euclid(i, slot, note, 32, 1)
    euclid(i, slot, note, 12, 7)
    euclid(i, slot, note, 14, 9)
    local slot = s:pattern(pattern):track(3):line(line):note_column(3)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root + 4] + base + math.floor(math.random() * 3) * 12 + 12
    euclid(i, slot, note, 32, 1)
    euclid(i, slot, note, 12, 7)
    euclid(i, slot, note, 14, 9)
    local slot = s:pattern(pattern):track(3):line(line):note_column(4)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root + 6] + base + math.floor(math.random() * 3) * 12 + 12
    euclid(i, slot, note, 32, 1)
    euclid(i, slot, note, 12, 7)
    euclid(i, slot, note, 14, 9)
    local slot = s:pattern(pattern):track(3):line(line):note_column(5)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root + 8] + base + math.floor(math.random() * 2) * 12 + 12
    euclid(i, slot, note, 32, 1)
    euclid(i, slot, note, 12, 7)
    euclid(i, slot, note, 14, 9)
    -- saxxx
    note.inst = 4
    note.vol = 0x7f
    local slot = s:pattern(pattern):track(4):line(line):note_column(1)
    note.pitch = key_notes[root + math.floor((i * 27) / 3) % 7 * 2] + base + 12
    euclid(i, slot, note, 12, 5)
    euclid(i, slot, note, 17, 7)
end    


local function part_b()
    local note = { inst = 1, vol = 0x7f }
    -- drums
    local slot = s:pattern(pattern):track(1):line(line):note_column(1)
    euclid(i, slot, perc_notes.kick_soft, 18, 1)
    euclid(i, slot, perc_notes.kick_soft, 24, 1)
    euclid(i, slot, perc_notes.kick_soft, 30, 1)
    euclid(i, slot, perc_notes.kick_soft, 56, 1)
    euclid(i, slot, perc_notes.kick, 16, 1)
    euclid(i, slot, perc_notes.kick, 16, 7)
    local slot = s:pattern(pattern):track(1):line(line):note_column(2)
    euclid(i, slot, perc_notes.snare_soft, 14, 11)
    euclid(i, slot, perc_notes.snare_soft, 19, 17)
    euclid(i, slot, perc_notes.snare_soft, 56, 29)
    euclid(i, slot, perc_notes.snare, 16, 13)
    local slot = s:pattern(pattern):track(1):line(line):note_column(3)
    note.pitch = 51;
    euclid(i, slot, note, 8, 5)
    -- bass
    local slot = s:pattern(pattern):track(2):line(line):note_column(1)
    local note_val = root + i % 16
    note = { inst = 2, pitch = key_notes[note_val] + base }
    note.vol = 0x5f
    euclid(i, slot, note, 14, 13)
    note.vol = 0x7f
    euclid(i, slot, note, 16, 1)
    euclid(i, slot, note, 16, 7)
    note.pitch = note.pitch + 5
    euclid(i, slot, note, 16, 13)
    --OFF
    note.pitch = 120
    note.vol = 0xff
    euclid(i, slot, note, 17, 0)
    euclid(i, slot, note, 11, 0)
    -- keys
    local note = { inst = 3, pitch = root, vol = 0x7f }
    local slot = s:pattern(pattern):track(3):line(line):note_column(1)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root] + base + math.floor(math.random() * 2) * 12 + 12
    euclid(i, slot, note, 8, 5)
    euclid(i, slot, note, 8, 7)
    --OFF
    note.pitch = 120
    note.vol = 0xff
    euclid(i, slot, note, 8, 6)
    euclid(i, slot, note, 8, 1)
    local slot = s:pattern(pattern):track(3):line(line):note_column(2)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root + 2] + base + math.floor(math.random() * 3) * 12 + 12
    euclid(i, slot, note, 8, 5)
    euclid(i, slot, note, 8, 7)
    --OFF
    note.pitch = 120
    note.vol = 0xff
    euclid(i, slot, note, 8, 6)
    euclid(i, slot, note, 8, 1)
    local slot = s:pattern(pattern):track(3):line(line):note_column(3)
    note.vol = math.floor(math.random() * 32 + 95)
    note.pitch = key_notes[root + 4] + base + math.floor(math.random() * 3) * 12 + 12
    euclid(i, slot, note, 8, 5)
    euclid(i, slot, note, 8, 7)
    --OFF
    note.pitch = 120
    note.vol = 0xff
    euclid(i, slot, note, 8, 6)
    euclid(i, slot, note, 8, 1)
    -- saxxx
    note.inst = 4
    note.vol = 0x7f
    local slot = s:pattern(pattern):track(4):line(line):note_column(1)
    note.pitch = key_notes[root + math.floor((i * 27) / 3) % 7 * 2] + base + 12
    euclid(i, slot, note, 34, 19)
    euclid(i, slot, note, 56, 27)
end
    
    
    

local function start() 
  rprint("runiing.g.g.....")
  math.randomseed(os.time())
  rprint(table.getn(s.patterns))
  local pc = table.getn(s.patterns)
  if pc == 0 then pc = 1 end
  -- clear patterns
  while (pc > 1) do
    s:pattern(pc):clear()
    pc = pc - 1
  end
  s:pattern(1):clear()
  -- clear sequences
  pc = table.getn(s.sequencer.pattern_sequence)
  while (pc > 1) do
    s.sequencer:delete_sequence_at(pc)
    pc = pc - 1
  end
  -- replace patterns
  pc = 1
  while (pc <= sequence_length) do
    pc = pc + 1
    s.sequencer:insert_new_pattern_at(pc)
  end
  -- set track widths
  s:track(1).visible_note_columns = 3
  s:track(3).visible_note_columns = 5
  -- iterate over patterns line by line :D/
  i = 0
  while i < pattern_length * sequence_length do
    pattern = math.floor(i / pattern_length) + 1
    line = i % pattern_length + 1
    -- root note value
    if line % 16 == 1 then
      root = math.floor((i * 27) / 3) % 7 + 1
    end
    -- jazz shit
    if line % 12 == 1 and pattern > 16 and pattern < 27 then
      base = (math.floor(i / 8) * 5) % 12 + 34
    end
    
    if pattern == 28  then base = 34 end
    
    if (pattern <= 4) then 
      part_a() 
    elseif (pattern <= 8) then 
      part_b()
    elseif (pattern <= 12) then 
      part_a() 
    elseif (pattern <= 20) then 
      part_b()
    else
      part_a() 
    end
    
    i = i + 1
  end
end






-- Menu Add

renoise.tool():add_menu_entry {
  name = "Main Menu:Tools:song gen:Crap",
  invoke = start  
}

start()
