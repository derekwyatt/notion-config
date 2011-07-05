
local bookmarks = {}

bookmark = {}

function bookmark.set_bookmark(bm, client)
    bookmarks[bm] = client
end

function bookmark.goto_bookmark(bm)
    if bookmarks[bm] then
        bookmarks[bm]:goto()
    end
end

function bookmark.move_here(ws, bm)
    if bookmarks[bm] then
        local frame = ws:current()
        frame:attach(bookmarks[bm], { swtichto = true })
        bookmarks[bm]:goto()
    end
end
