start_at_login(true)

disable /VirtualBox/

# Enable/disable Keymando
toggle "<Ctrl-E>"

map "<Cmd-h>", Commands.press_button_on_ui
map "<Cmd- >", Commands.run_registered_command
map "<Cmd-.>", Commands.run_last_command

# map ";i", lambda {activate("iTerm")}
# map ";g", lambda {activate("Google Chrome")}
# map ";s", lambda {activate("Spotify")}

except /(iTerm|MacVim)/ do
  map ";uic", Commands.ui_controls
  map ";lc", Commands.left_click_element
  map ";rc", Commands.right_click_element
  map ";dc", Commands.double_click_element
  map ";mi", Commands.show_current_app_menu_items
end

# Basic mapping
map "<Ctrl-[>", "<Escape>"
map "<Ctrl-m>", "<Ctrl-F2>"

map "<Cmd-Tab>", nil
map "<Cmd-Shift-Tab>", nil

# The following mappings are valid 
# except for these application(s)
except /iTerm/, "MacVim" do
  map "<Ctrl-j>", "<Down>"
  map "<Ctrl-k>", "<Up>"
  map "<Ctrl-h>", "<Left>"
  map "<Ctrl-l>", "<Right>"
  map "<Ctrl-f>", "<PageUp>"
  map "<Ctrl-b>", "<PageDown>"

  map "<Ctrl-Shift-j>", "<Shift-Down>"
  map "<Ctrl-Shift-k>", "<Shift-Up>"
  map "<Ctrl-Shift-h>", "<Shift-Left>"
  map "<Ctrl-Shift-l>", "<Shift-Right>"
end

# Disable quiting for iTerm.  Should only exit via command line
only /iTerm/ do
  map "<Cmd-w>", nil
  map "<Cmd-q>", nil
  map "<Cmd-r>", nil
  map "<Cmd-t>", nil
end

# The following mappings are only valid for
# the given application(s)
only /Chrome/, /Firefox/ do
  map "<Ctrl-h>", "<Cmd-{>"
  map "<Ctrl-l>", "<Cmd-}>"
  map '<Ctrl-a>p', '<Cmd-{>'
  map '<Ctrl-a>n', '<Cmd-}>'
  map '<Ctrl-w>h', '<Cmd-{>'
  map '<Ctrl-w>l', '<Cmd-}>'
  map "<Ctrl-u>", "<PageUp>"
  map "<Ctrl-d>", "<PageDown>"
  map ';r', '<Cmd-r>'
  map ';t', '<Cmd-t>'
  map ';l', '<Cmd-y>'
  map ';w', '<Cmd-w>'
end

# Mac Outlook
only /Outlook/ do
  nmap "#", "<Delete>"
  nmap "c", "<Cmd-n>"
  nmap "y" do
    send("<Cmd-Shift-m>")
    send("Archive<Enter>")
  end
  nmap "v" do
    send("<Cmd-Shift-m>")
  end
end

# Xcode
only /Xcode/ do
  map ',r', '<Cmd-r>'
end

# FileSystem plugin
except /(iTerm|MacVim)/ do
  map ";h", lambda { FileSystem.home }
  map ";f", lambda { FileSystem.root }
end

abbrev 'nname', 'Kevin Colyar'
abbrev 'ttime' do
  send(Time.now.strftime('%I:%M%p'))
end
abbrev 'ddate' do
  send(Time.now.strftime('%m/%d/%Y'))
end
abbrev 'eemail', 'kevin@colyar.net'
abbrev 'addr', '123 Willow Rd., New York, NY, 122345'
abbrev 'teh', 'the'
abbrev 'shoudl', 'should'


ApplicationLauncher.register('/System/Library/CoreServices', :max_depth => 1)
ApplicationLauncher.register('/Applications', :max_depth => 2)
# #
# ChromeBookmarks.register('/Users/kevinc/Library/Application Support/Google/Chrome/Default/Bookmarks')

# Commands

command 'Keymando - Reload' do
  alert('Reloaded Successfully') if reload
end

command "Window close current" do
  send("<Cmd-w>")
end

command "Quit current application" do
  send("<Cmd-q>")
end

command 'Eject Volume' do
  volumes = Find.find('/Volumes', :type => 'd', :extension => '', :max_depth => 1)
  trigger_item_with(volumes, EjectVolume.new)
end

command 'Mount Volume' do
  volumes = Find.find('/Users/kevinc/disk_images', :type => 'f', :extension => '.dmg')
  trigger_item_with(volumes, LaunchItem.new)
end

command "Chrome - Refresh" do
  app = Accessibility::Gateway.get_application_by_name "Firefox"
  menu_item = app.menu_bar.find.first_item_matching(:role => Matches.partial("menuitem"), :title => Matches.exact("Reload"))
  menu_item.press
end

command "Finder - Underscorify" do
  send('<Return><Cmd-c>')
  pb = pasteboard
  str = pb.downcase.gsub(/[ -]/, '_')
  pasteboard = str
  send('<Cmd-v><Return>')
end

# map "<Ctrl-r>" do
#   app = Accessibility::Gateway.get_application_by_name "Google Chrome"
#   menu_item = app.menu_bar.find.first_item_matching(:role => Matches.partial("menuitem"), :title => Matches.exact("Reload This Page"))
#   menu_item.press
# end

command "Keymando - Edit Config" do
  system('open /Users/kevinc/.keymandorc.rb')
end

command "Open Dropbox" do
  system('open /Users/kevinc/Dropbox')
end

command "Volume Up" do
  `osascript -e 'set volume output volume (output volume of (get volume settings) + 7)'`
end

command "Volume Down" do
  `osascript -e 'set volume output volume (output volume of (get volume settings) - 7)'`
end


command 'test' do
  # key_down('<Cmd>')
  # key_down('a')
  # key_up('a')
  # key_up('<Cmd>')
  #
  # key_down('<Shift>')
  # key_press('<Down>')
  # key_press('<Down>')
  # key_press('<Down>')
  # key_up('<Shift>')

  # left_click_holding('<Cmd>')
  # send('<cmd-a>')
  #
  # key_down('<ctrl>')
  # left_click
  # key_up('<ctrl>')
  #
  # holding_key('<ctrl>') do
  #   left_click
  # end

  # holding_key('<shift>') do
  #   key_press('<Down>')
  #   key_press('<Down>')
  #   key_press('<Down>')
  # end
  #
end

# map "<Alt-F>", "<Alt-Right><Alt-Right><Alt-Left>"
# map "<Alt-B>", "<Alt-Left>"
# map "<Ctrl-d>", "<Alt-right>" 
# 
# map "<Ctrl-Shift-m>", "<Cmd-Alt->>"
# 
# map "<alt-f>", "<cmd-right>", :if => lambda { key_down?("<rightalt>") }
# map "<alt-b>", "<cmd-right>", :if => lambda { key_up?("<rightalt>") }

# MessageBoard.change_notifier_to(GrowlNotifier)
