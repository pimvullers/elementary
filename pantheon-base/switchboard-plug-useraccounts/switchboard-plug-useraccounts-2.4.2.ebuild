# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="Switchboard User Accounts Plug."
HOMEPAGE="https://github.com/elementary/switchboard-plug-useraccounts"
SRC_URI="https://github.com/elementary/switchboard-plug-useraccounts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	dev-libs/libpwquality
	gnome-base/gnome-desktop:3=
	>=gui-libs/libhandy-1.1.90:1
	pantheon-base/switchboard
	sys-apps/accountsservice
	>=sys-auth/polkit-0.115
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user

	vala_src_prepare
}

