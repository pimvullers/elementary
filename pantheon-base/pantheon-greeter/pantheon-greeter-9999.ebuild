# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson vala xdg

DESCRIPTION="LightDM Greeter for Pantheon"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI=""
EGIT_REPO_URI="https://github.com/elementary/greeter.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	>=gui-libs/libhandy-1.1.90:=
	sys-apps/accountsservice
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-misc/lightdm[introspection,vala]
	>=x11-wm/mutter-3.36.0:=
"

src_prepare() {
	eapply_user
	vala_setup
}
