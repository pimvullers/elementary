# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Pantheon DE shell"
HOMEPAGE="https://github.com/elementary/session-settings"
SRC_URI="https://github.com/elementary/session-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE="accessibility gnome-keyring"

DEPEND=""
RDEPEND="${DEPEND}
	accessibility? (
		app-accessibility/orca
		app-accessibility/onboard
	)
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	gnome-base/gsettings-desktop-schemas
	gnome-keyring? ( gnome-base/gnome-keyring )
	pantheon-base/applications-menu
	>=pantheon-base/wingpanel-3.0.0
	pantheon-extra/pantheon-agent-polkit
	x11-misc/plank
	>=x11-wm/gala-6.0.0
"

PDEPEND="
	pantheon-base/pantheon-settings
"

S="${WORKDIR}/session-settings-${PV}"


src_prepare() {
	eapply_user

	eapply "${FILESDIR}/${PV}-fix_access_deps.patch"
	use accessibility || sed -i -e "/orca/d" session/meson.build
	use accessibility || sed -i -e "/onboard/d" session/meson.build
	use gnome-keyring || sed -i -e "/gnome-keyring/d" session/meson.build
}

