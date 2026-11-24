# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 gnome2 meson vala

DESCRIPTION="LightDM Greeter for Pantheon"
HOMEPAGE="https://github.com/elementary/greeter"
EGIT_REPO_URI="https://github.com/elementary/greeter"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-libs/glib:2
	<dev-libs/granite-7:0
	dev-libs/libgee:0.8
	gui-libs/libhandy:1
	sys-apps/accountsservice
	gnome-base/gnome-desktop:3
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-misc/lightdm[introspection,vala]
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
