# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8
inherit autotools gnome2 vala

DESCRIPTION="Elegant, simple, clean dock"
HOMEPAGE="https://github.com/ricotz/plank"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"
IUSE="apport barriers benchmark dbus debug nls"

VALA_MIN_API_VERSION="0.34"
VALA_USE_DEPEND="vapigen"

RDEPEND="dev-libs/atk
	dev-libs/glib:2
	dev-libs/libdbusmenu[gtk,gtk3]
	dev-libs/libgee
	sys-libs/glibc
	x11-libs/bamf
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libwnck
	gnome-base/gnome-menus:3
	x11-libs/pango"

DEPEND="${RDEPEND}
	$(vala_depend)"

src_prepare() {
	eapply_user
	eautoreconf
	vala_setup
}

src_configure() {
	econf \
		$(use_enable apport) \
		$(use_enable barriers) \
		$(use_enable benchmark) \
		$(use_enable dbus dbusmenu) \
		$(use_enable debug) \
		$(use_enable nls)
}

