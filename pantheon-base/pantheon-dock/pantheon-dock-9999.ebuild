# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 git-r3 meson vala

DESCRIPTION="A quick app launcher and window switcher for Pantheon"
HOMEPAGE="https://github.com/elementary/dock"
SRC_URI=""
EGIT_REPO_URI="https://github.com/elementary/dock.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="gui-libs/gtk"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user
	vala_setup
}
